locals {
  suffix = data.terraform_remote_state.state1.outputs.suffix
}

resource "aws_s3_bucket" "example" {
  bucket        = "aws-polly-python-${local.suffix}"
  force_destroy = true
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_dynamodb_table" "example" {
  name         = "aws-polly-python-${local.suffix}"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "PlayerId"
    type = "S"
  }

  attribute {
    name = "MatchId"
    type = "N"
  }

  hash_key  = "PlayerId"
  range_key = "MatchId"

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table_item" "player_1_match_1" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = "PlayerId"
  range_key  = "MatchId"

  item = <<ITEM
{
  "PlayerId": {"S": "player_1"},
  "MatchId": {"N": "1"},
  "Goals": {"N": "2"},
  "Assists": {"N": "1"},
  "MinutesPlayed": {"N": "90"},
  "Performance": {"S": "A standout performer from the first whistle."}
}
ITEM
}

resource "aws_dynamodb_table_item" "player_1_match_2" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = "PlayerId"
  range_key  = "MatchId"

  item = <<ITEM
{
  "PlayerId": {"S": "player_1"},
  "MatchId": {"N": "2"},
  "Goals": {"N": "1"},
  "Assists": {"N": "0"},
  "MinutesPlayed": {"N": "80"},
  "Performance": {"S": "Setting the tone for the game."}
}
ITEM
}

resource "aws_dynamodb_table_item" "player_2_match_1" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = "PlayerId"
  range_key  = "MatchId"

  item = <<ITEM
{
  "PlayerId": {"S": "player_2"},
  "MatchId": {"N": "1"},
  "Goals": {"N": "0"},
  "Assists": {"N": "2"},
  "MinutesPlayed": {"N": "85"},
  "Performance": {"S": "Pivotal in shaping the team's strategy early on."}
}
ITEM
}

resource "aws_dynamodb_table_item" "player_2_match_2" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = "PlayerId"
  range_key  = "MatchId"

  item = <<ITEM
{
  "PlayerId": {"S": "player_2"},
  "MatchId": {"N": "2"},
  "Goals": {"N": "3"},
  "Assists": {"N": "1"},
  "MinutesPlayed": {"N": "90"},
  "Performance": {"S": "Commanding presence since kick-off."}
}
ITEM
}

resource "aws_dynamodb_table_item" "player_3_match_1" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = "PlayerId"
  range_key  = "MatchId"

  item = <<ITEM
{
  "PlayerId": {"S": "player_3"},
  "MatchId": {"N": "1"},
  "Goals": {"N": "2"},
  "Assists": {"N": "0"},
  "MinutesPlayed": {"N": "75"},
  "Performance": {"S": "Showing why they're a key player right from the start."}
}
ITEM
}

resource "aws_dynamodb_table_item" "player_3_match_2" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = "PlayerId"
  range_key  = "MatchId"

  item = <<ITEM
{
  "PlayerId": {"S": "player_3"},
  "MatchId": {"N": "2"},
  "Goals": {"N": "1"},
  "Assists": {"N": "2"},
  "MinutesPlayed": {"N": "88"},
  "Performance": {"S": "Instrumental in dictating the flow of the match."}
}
ITEM
}

resource "aws_dynamodb_table_item" "player_4_match_1" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = "PlayerId"
  range_key  = "MatchId"

  item = <<ITEM
{
  "PlayerId": {"S": "player_4"},
  "MatchId": {"N": "1"},
  "Goals": {"N": "0"},
  "Assists": {"N": "2"},
  "MinutesPlayed": {"N": "82"},
  "Performance": {"S": "A driving force since the opening moments."}
}
ITEM
}

resource "aws_dynamodb_table_item" "player_4_match_2" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = "PlayerId"
  range_key  = "MatchId"

  item = <<ITEM
{
  "PlayerId": {"S": "player_4"},
  "MatchId": {"N": "2"},
  "Goals": {"N": "3"},
  "Assists": {"N": "1"},
  "MinutesPlayed": {"N": "84"},
  "Performance": {"S": "Making an immediate impact on the game."}
}
ITEM
}

resource "aws_dynamodb_table_item" "player_4_match_3" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = "PlayerId"
  range_key  = "MatchId"

  item = <<ITEM
{
  "PlayerId": {"S": "player_4"},
  "MatchId": {"N": "3"},
  "Goals": {"N": "2"},
  "Assists": {"N": "0"},
  "MinutesPlayed": {"N": "87"},
  "Performance": {"S": "Showing class right from the outset."}
}
ITEM
}

resource "aws_cloudwatch_log_group" "create_update" {
  name              = "/aws/lambda/aws-polly-python-${local.suffix}-create-update"
  retention_in_days = 1

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_cloudwatch_log_group" "delete" {
  name              = "/aws/lambda/aws-polly-python-${local.suffix}-delete"
  retention_in_days = 1

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_cloudwatch_log_group" "dictate" {
  name              = "/aws/lambda/aws-polly-python-${local.suffix}-dictate"
  retention_in_days = 1

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_cloudwatch_log_group" "list" {
  name              = "/aws/lambda/aws-polly-python-${local.suffix}-list"
  retention_in_days = 1

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_cloudwatch_log_group" "search" {
  name              = "/aws/lambda/aws-polly-python-${local.suffix}-search"
  retention_in_days = 1

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_iam_role" "lambda_create_update" {
  name = "aws-polly-python-${local.suffix}-create-update"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_create_update" {
  name = "aws-polly-python-${local.suffix}-create-update"
  role = aws_iam_role.lambda_create_update.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DescribeTable"
        ],
        "Resource" : "${aws_dynamodb_table.example.arn}",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "${aws_cloudwatch_log_group.create_update.arn}",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_lambda_function" "lambda_create_update" {
  filename         = "${path.module}/../01/external/create_update_function.zip"
  function_name    = "aws-polly-python-${local.suffix}-create-update"
  role             = aws_iam_role.lambda_create_update.arn
  handler          = "app.lambda_handler"
  source_code_hash = filebase64sha256("${path.module}/../01/external/create_update_function.zip")
  runtime          = "python3.12"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.example.name
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.create_update
  ]
}

resource "aws_iam_role" "lambda_delete" {
  name = "aws-polly-python-${local.suffix}-delete"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_delete" {
  name = "aws-polly-python-${local.suffix}-delete"
  role = aws_iam_role.lambda_delete.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable"
        ],
        "Resource" : "${aws_dynamodb_table.example.arn}",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "${aws_cloudwatch_log_group.delete.arn}",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_lambda_function" "lambda_delete" {
  filename         = "${path.module}/../01/external/delete_function.zip"
  function_name    = "aws-polly-python-${local.suffix}-delete"
  role             = aws_iam_role.lambda_delete.arn
  handler          = "app.lambda_handler"
  source_code_hash = filebase64sha256("${path.module}/../01/external/delete_function.zip")
  runtime          = "python3.12"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.example.name
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.delete
  ]
}

resource "aws_iam_role" "lambda_dictate" {
  name = "aws-polly-python-${local.suffix}-dictate"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_dictate" {
  name = "aws-polly-python-${local.suffix}-dictate"
  role = aws_iam_role.lambda_dictate.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "dynamodb:dictateItem",
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem",
          "dynamodb:DescribeTable"
        ],
        "Resource" : "${aws_dynamodb_table.example.arn}",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "${aws_cloudwatch_log_group.dictate.arn}",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "polly:SynthesizeSpeech"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "s3:PutObject",
          "s3:GetObject"
        ],
        "Resource" : "${aws_s3_bucket.example.arn}*",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_lambda_function" "lambda_dictate" {
  filename         = "${path.module}/../01/external/dictate_function.zip"
  function_name    = "aws-polly-python-${local.suffix}-dictate"
  role             = aws_iam_role.lambda_dictate.arn
  handler          = "app.lambda_handler"
  source_code_hash = filebase64sha256("${path.module}/../01/external/dictate_function.zip")
  runtime          = "python3.12"

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.example.bucket
      TABLE_NAME  = aws_dynamodb_table.example.name
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.dictate
  ]
}

resource "aws_iam_role" "lambda_list" {
  name = "aws-polly-python-${local.suffix}-list"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_list" {
  name = "aws-polly-python-${local.suffix}-list"
  role = aws_iam_role.lambda_list.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "dynamodb:GetItem",
          "dynamodb:Scan"
        ],
        "Resource" : "${aws_dynamodb_table.example.arn}",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "${aws_cloudwatch_log_group.list.arn}",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_lambda_function" "list" {
  filename         = "${path.module}/../01/external/list_function.zip"
  function_name    = "aws-polly-python-${local.suffix}-list"
  role             = aws_iam_role.lambda_list.arn
  handler          = "app.lambda_handler"
  source_code_hash = filebase64sha256("${path.module}/../01/external/list_function.zip")
  runtime          = "python3.12"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.example.name
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.list
  ]
}

resource "aws_iam_role" "lambda_search" {
  name = "aws-polly-python-${local.suffix}-search"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_search" {
  name = "aws-polly-python-${local.suffix}-search"
  role = aws_iam_role.lambda_search.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "dynamodb:Query",
          "dynamodb:DescribeTable"
        ],
        "Resource" : "${aws_dynamodb_table.example.arn}",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "${aws_cloudwatch_log_group.search.arn}",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_lambda_function" "lambda_search" {
  filename         = "${path.module}/../01/external/search_function.zip"
  function_name    = "aws-polly-python-${local.suffix}-search"
  role             = aws_iam_role.lambda_search.arn
  handler          = "app.lambda_handler"
  source_code_hash = filebase64sha256("${path.module}/../01/external/search_function.zip")
  runtime          = "python3.12"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.example.name
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.search
  ]
}
