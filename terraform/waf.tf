resource "aws_wafv2_web_acl" "waf" {
  name  = "waf-acl"
  scope = "REGIONAL"

  default_action {
      allow {}
  }

  rule {
    name     = "block-bad-ips"
    priority = 1

    action {
        block {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.bad_ips.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "block-bad-ips"
    }
  }

  rule {
    name     = "captcha-rule"
    priority = 2

    action {
      challenge {}
    }

    statement {
      rate_based_statement {
        limit              = 1000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "captcha-rule"
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    sampled_requests_enabled   = true
    metric_name                = "wafACL"
  }
}

resource "aws_wafv2_ip_set" "bad_ips" {
  name               = "bad-ips"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["192.168.1.1/32", "203.0.113.0/24"]
}
resource "aws_wafv2_web_acl_association" "waf_assoc" {
  resource_arn = aws_lb.my_alb.arn  
  web_acl_arn  = aws_wafv2_web_acl.waf.arn
}
