resource "aws_ecs_cluster" "main" {
  name = "SIT-TangTruong"
}

resource "aws_ecs_task_definition" "main" {
  family = "sit-appvay"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = "arn:aws:iam::356705062463:role/ecsTaskExecutionRole"
  task_role_arn            = "arn:aws:iam::356705062463:role/ecsTaskExecutionRole"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "sit-appvay",
      "image": "public.ecr.aws/b8v4t5d9/api-masterdata-jenkins:dev",
      "entryPoint": [],
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "main" {
 name                               = "SIT-AppVay"
 cluster                            = aws_ecs_cluster.main.id
 task_definition                    = aws_ecs_task_definition.main.arn
 desired_count                      = 2
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 200
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"
 
 network_configuration {
   security_groups  = [aws_security_group.alb.id]
   subnets          = module.vpc.public_subnets
   assign_public_ip = false
 }
 
 load_balancer {
   target_group_arn = aws_alb_target_group.main.id
   container_name   = "sit-appvay"
   container_port   = 80
 }
 
 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
}