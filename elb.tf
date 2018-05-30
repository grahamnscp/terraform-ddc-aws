# ELBs:

resource "aws_elb" "ucp" {
    name = "${var.name_prefix}-ucp"
    security_groups = [
        "${aws_security_group.elb.id}",
    ]
    availability_zones = ["${split(",", var.availability_zones)}"]

    listener {
        instance_port = 443
        instance_protocol = "tcp"
        lb_port = 443
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 6443
        instance_protocol = "tcp"
        lb_port = 6443
        lb_protocol = "tcp"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 10
        timeout = 5
        target = "TCP:443"
        interval = 30
    }

    instances = ["${aws_instance.ucp-manager.*.id}"]
    idle_timeout = 240
    cross_zone_load_balancing = true
}

resource "aws_elb" "dtr" {
    name = "${var.name_prefix}-dtr"
    security_groups = [
        "${aws_security_group.dtr.id}",
    ]
    availability_zones = ["${split(",", var.availability_zones)}"]

    listener {
        instance_port = 80
        instance_protocol = "tcp"
        lb_port = 80
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 443
        instance_protocol = "tcp"
        lb_port = 443
        lb_protocol = "tcp"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 10
        timeout = 5
        target = "TCP:443"
        interval = 30
    }

    instances = ["${aws_instance.ucp-dtr.*.id}"]
    idle_timeout = 240
    cross_zone_load_balancing = true
}

resource "aws_elb" "apps" {
    name = "${var.name_prefix}-apps"
    security_groups = [
        "${aws_security_group.apps.id}",
    ]
    availability_zones = ["${split(",", var.availability_zones)}"]

    listener {
        instance_port = 80
        instance_protocol = "tcp"
        lb_port = 80
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 443
        instance_protocol = "tcp"
        lb_port = 443
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8080
        instance_protocol = "tcp"
        lb_port = 8080
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8081
        instance_protocol = "tcp"
        lb_port = 8081
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8082
        instance_protocol = "tcp"
        lb_port = 8082
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8083
        instance_protocol = "tcp"
        lb_port = 8083
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8084
        instance_protocol = "tcp"
        lb_port = 8084
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8085
        instance_protocol = "tcp"
        lb_port = 8085
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33080
        instance_protocol = "tcp"
        lb_port = 33080
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33081
        instance_protocol = "tcp"
        lb_port = 33081
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33082
        instance_protocol = "tcp"
        lb_port = 33082
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33083
        instance_protocol = "tcp"
        lb_port = 33083
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33084
        instance_protocol = "tcp"
        lb_port = 33084
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33085
        instance_protocol = "tcp"
        lb_port = 33085
        lb_protocol = "tcp"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 10
        timeout = 5
        target = "TCP:443"
        interval = 30
    }

    instances = ["${aws_instance.ucp-worker.*.id}"]
    cross_zone_load_balancing = true
}

resource "aws_elb" "kapps" {
    name = "${var.name_prefix}-kapps"
    security_groups = [
        "${aws_security_group.kapps.id}",
    ]
    availability_zones = ["${split(",", var.availability_zones)}"]

    listener {
        instance_port = 80
        instance_protocol = "tcp"
        lb_port = 80
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 443
        instance_protocol = "tcp"
        lb_port = 443
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8080
        instance_protocol = "tcp"
        lb_port = 8080
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8081
        instance_protocol = "tcp"
        lb_port = 8081
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8082
        instance_protocol = "tcp"
        lb_port = 8082
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8083
        instance_protocol = "tcp"
        lb_port = 8083
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8084
        instance_protocol = "tcp"
        lb_port = 8084
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 8085
        instance_protocol = "tcp"
        lb_port = 8085
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33080
        instance_protocol = "tcp"
        lb_port = 33080
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33081
        instance_protocol = "tcp"
        lb_port = 33081
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33082
        instance_protocol = "tcp"
        lb_port = 33082
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33083
        instance_protocol = "tcp"
        lb_port = 33083
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33084
        instance_protocol = "tcp"
        lb_port = 33084
        lb_protocol = "tcp"
    }

    listener {
        instance_port = 33085
        instance_protocol = "tcp"
        lb_port = 33085
        lb_protocol = "tcp"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 10
        timeout = 5
        target = "TCP:443"
        interval = 30
    }

    instances = ["${aws_instance.ucp-worker.*.id}"]
    cross_zone_load_balancing = true
}
