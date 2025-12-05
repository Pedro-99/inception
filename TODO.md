

pid 1 and how daemons work on linux (infinite loop commands . . .)
    - https://www.geeksforgeeks.org/operating-systems/daemon-processes/ 


cAdvisor Overview
cAdvisor (Container Advisor) is an open-source monitoring tool developed by Google that collects, processes, and exports resource usage and performance metrics from running containers.
What It Does
cAdvisor analyzes and exposes resource usage and performance data from running containers Prometheus, automatically discovering all containers on a host and tracking their:

CPU usage and load averages
Memory consumption
Network statistics (bandwidth, errors)
Filesystem I/O operations
Disk usage

Key Features

Automatic discovery: Whenever cAdvisor detects a new container running on the host machine, it automatically starts capturing the metrics Medium
Built-in web UI: Accessible at http://localhost:8080 with real-time graphs and statistics
Prometheus integration: cAdvisor exposes Prometheus metrics out of the box Prometheus via the /metrics endpoint
Multiple deployment options: Run as Docker container, standalone binary, or Kubernetes DaemonSet
Lightweight: Minimal overhead while monitoring

Important Limitations

No long-term storage: cAdvisor itself does not have built-in storage for the metrics it collects Medium - it's designed for real-time monitoring only
Basic metrics only: Doesn't provide deep application-level insights
Requires external tools: For historical data, alerting, and advanced visualization, you need to pair it with tools like Prometheus and Grafana

Common Use Cases
The typical monitoring stack combines:

cAdvisor - Collects container metrics
Prometheus - Stores metrics long-term and enables querying
Grafana - Creates visual dashboards and alerts

This is exactly what your Docker Compose setup enables - cAdvisor will monitor your containers in real-time and expose metrics that other tools can consume!