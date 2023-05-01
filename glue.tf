locals {
  glue_script = <<-EOT
    import sys
    from awsglue.transforms import *
    from awsglue.utils import getResolvedOptions
    from pyspark.context import SparkContext
    from awsglue.context import GlueContext
    from awsglue.job import Job

    args = getResolvedOptions(sys.argv, ['JOB_NAME'])

    sc = SparkContext()
    glueContext = GlueContext(sc)
    spark = glueContext.spark_session
    job = Job(glueContext)
    job.init(args['JOB_NAME'], args)

    input_path = "s3://source-s3-bucket-poc/Sample-Spreadsheet-100-rows.csv"
    output_path = "s3://destination-s3-bucket-poc/Output/"

    datasource0 = glueContext.create_dynamic_frame.from_options(
        connection_type="s3",
        connection_options={
            "paths": [input_path],
            "recurse": True
        },
        format="csv",
        format_options={
            "withHeader": True,
            "delimiter": ","
        },
        transformation_ctx="datasource0"
    )

    transformed = datasource0.select_fields(["column1", "column2", "column3"])

    glueContext.write_dynamic_frame.from_options(
        frame=transformed,
        connection_type="s3",
        connection_options={"path": output_path},
        format="parquet",
        transformation_ctx="sink"
    )

    job.commit()
  EOT
}

resource "aws_glue_catalog_database" "example" {
  name = "example"
}

resource "aws_glue_job" "example" {
  name     = "example"
  role_arn = aws_iam_role.example.arn

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_bucket.example.bucket}/${aws_s3_bucket_object.example.key}"
  }

  depends_on = [aws_s3_bucket_object.example]
}

resource "local_file" "example" {
  content  = local.glue_script
  filename = "example-job-script.py"
}
