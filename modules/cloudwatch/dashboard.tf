resource "aws_cloudwatch_dashboard" "shopsphere" {

  dashboard_name = "shopsphere-dashboard"

  dashboard_body = jsonencode({

    widgets = [

      #
      # ECS CPU
      #
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {

          title = "ECS CPU Utilization"

          metrics = [

            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName",
              var.cluster_name,
              "ServiceName",
              var.frontend_service_name
            ],

            [
              "...",
              var.backend_service_name
            ]

          ]

          stat   = "Average"
          period = 300
          region = "us-east-1"

        }

      },

      #
      # ECS Memory
      #
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {

          title = "ECS Memory Utilization"

          metrics = [

            [
              "AWS/ECS",
              "MemoryUtilization",
              "ClusterName",
              var.cluster_name,
              "ServiceName",
              var.frontend_service_name
            ],

            [
              "...",
              var.backend_service_name
            ]

          ]

          stat   = "Average"
          period = 300
          region = "us-east-1"

        }

      },

      #
      # ALB Request Count
      #
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {

          title = "ALB Request Count"

          metrics = [

            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              var.alb_arn_suffix
            ]

          ]

          stat   = "Sum"
          period = 300
          region = "us-east-1"

        }

      },

      #
      # ALB Response Time
      #
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {

          title = "Target Response Time"

          metrics = [

            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "LoadBalancer",
              var.alb_arn_suffix
            ]

          ]

          stat   = "Average"
          period = 300
          region = "us-east-1"

        }

      },

      #
      # Backend Healthy Hosts
      #
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6

        properties = {

          title = "Backend Healthy Targets"

          metrics = [

            [
              "AWS/ApplicationELB",
              "HealthyHostCount",
              "TargetGroup",
              var.backend_target_group_arn_suffix,
              "LoadBalancer",
              var.alb_arn_suffix
            ]

          ]

          stat   = "Average"
          period = 300
          region = "us-east-1"

        }

      },

      #
      # RDS CPU
      #
      {
        type   = "metric"
        x      = 12
        y      = 12
        width  = 12
        height = 6

        properties = {

          title = "RDS CPU Utilization"

          metrics = [

            [
              "AWS/RDS",
              "CPUUtilization",
              "DBInstanceIdentifier",
              var.db_instance_id
              
            ]

          ]

          stat   = "Average"
          period = 300
          region = "us-east-1"

        }

      }

    ]

  })

}