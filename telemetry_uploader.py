import time
import json
import random
import boto3

#S3 client (Uses IAM role attached to EC2)
s3 = boto3.client('s3')
bucket = "telemetry-ingestion-jb"
raw_prefix = "raw/"
decoded_prefix = "decoded/"

cloudwatch = boto3.client('cloudwatch')
namespace = "Telemetry"
metric_name = "PacketsPerMinute"


def generate_packet():
    return {
        "timestamp": time.time(),
        "satellite_id": "SAT-42",
        "battery_voltage": round(random.uniform(2.9, 4.2), 2),
        "temperature" : random.randint(-20, 60),
    }

def upload_to_s3(packet, prefix=raw_prefix):
    filename = f"{prefix}packet-{int(time.time())}.json"
    s3.put_object(Bucket=bucket, Key=filename, Body=json.dumps(packet))
    print(f"Uploaded {filename}")

def decode_packet(packet):
    packet["status"] = "OK" if packet["battery_voltage"] > 3.0 else "LOW_BATTERY"
    return packet

def upload_decoded(packet):
    decoded = decode_packet(packet)
    filename = f"{decoded_prefix}packet-{int(time.time())}.json"
    s3.put_object(Bucket=bucket, Key=filename, Body=json.dumps(decoded))
    print(f"Uploaded decoded {filename}")


def send_metric(count=1):
    """
    Senda a metric to CloudWatch.
    count: number of packets uploaded in this iteration
    """
    cloudwatch.put_metric_data(
        Namespace=namespace,
        MetricData=[
            {
                'MetricName': metric_name,
                'Unit': 'Count',
                'Value': count
            }
        ]
    )
    print(f"Sent CloudWatch metric: {count} packet(s)")


if __name__ == "__main__":
    for _ in range(20):
        packet = generate_packet()
        upload_to_s3(packet)
        upload_decoded(packet)
        send_metric()
        time.sleep(5)  # simulate 5-second heartbeat
