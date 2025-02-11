# System Monitoring & Performance Analysis
# Your team has been receiving complaints about server slowness during peak hours. You suspect a process might be consuming too many resources. Your tasks are:
# Identify the top resource-consuming process and determine if it is necessary.
# Check the disk usage to ensure logs are not consuming too much space.
# Monitor real-time system logs to detect anomalies.

# 1. Identify the top resource-consuming processes
top  
# Press Shift + P (Sort by CPU)  
# Press Shift + M (Sort by Memory) 

# If a process is unnecessary, kill it
sudo kill -9 <PID>   # Replace <PID> with actual process ID 


# 2. Check overall disk usage 
df -h  

# Check the total size of the logs directory to ensure logs are not consuming too much space
du -sh /var/log

# Find the largest log files 
du -ah /var/log | sort -rh | head -5


# 3. Monitor real-time system logs to detect anomalies
sudo journalctl -f  
