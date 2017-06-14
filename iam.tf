# IAM

# Create an IAM role for the Web Servers.
resource "aws_iam_role" "dtr_iam_role" {
    name = "${var.name_prefix}_dtr_iam_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "dtr_instance_profile" {
    name = "${var.name_prefix}_dtr_instance_profile"
    role = "dtr_iam_role"
}

resource "aws_iam_role_policy" "dtr_iam_role_policy" {
  name = "${var.name_prefix}_dtr_iam_role_policy"
  role = "${aws_iam_role.dtr_iam_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [ "s3:ListAllMyBuckets",
                  "s3:GetBucketLocation" 
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:GetObject"
       ],
      "Resource": ["arn:aws:s3:::${aws_s3_bucket.dtr-storage-bucket.id}"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload"
      ],
      "Resource": ["arn:aws:s3:::${aws_s3_bucket.dtr-storage-bucket.id}/*"]
    }
  ]
}
EOF
}

