# Dynamo configuration
resource aws_dynamodb_table books_table {
  provider = aws
  name = var.tableName
  billing_mode = "PROVISIONED"
  hash_key = "id"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity = 1
  write_capacity = 1

  attribute {
    name = "id"
    type = "S"
  }

/*
  replica {
    region_name = "us-west-2"
  }
*/

  tags = var.tags
}

resource aws_dynamodb_table_item item {
  table_name = aws_dynamodb_table.books_table.name
  hash_key   = aws_dynamodb_table.books_table.hash_key

  item = <<ITEM
{
  "id": {"S": "1"},
  "isbn": {"S": "ISBN-1234"},
  "title": {"S": "Title"},
  "author": {"S": "Author"},
  "publisher": {"S": "Publisher"},
  "coverUrl": {"S": "/book-0.png"}
}
ITEM
}

resource aws_appautoscaling_target books_table_read_target {
  max_capacity = 10
  min_capacity = 1
  resource_id = "table/${var.tableName}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace = "dynamodb"

  depends_on = [aws_dynamodb_table.books_table]
}

resource aws_appautoscaling_policy books_table_read_policy {
  name = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.books_table_read_target.resource_id}"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.books_table_read_target.resource_id
  scalable_dimension = aws_appautoscaling_target.books_table_read_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.books_table_read_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }
    target_value = 70
  }
}

resource aws_appautoscaling_target books_table_write_target {
  max_capacity = 10
  min_capacity = 1
  resource_id = "table/${var.tableName}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace = "dynamodb"

  depends_on = [aws_dynamodb_table.books_table]
}

resource aws_appautoscaling_policy books_table_write_policy {
  name = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.books_table_write_target.resource_id}"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.books_table_write_target.resource_id
  scalable_dimension = aws_appautoscaling_target.books_table_write_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.books_table_write_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }
    target_value = 70
  }
}
