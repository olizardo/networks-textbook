import urllib.request
import json
import sys

def main():
    repo = "olizardo/networks-textbook"
    runs_url = f"https://api.github.com/repos/{repo}/actions/runs"
    
    headers = {"User-Agent": "Mozilla/5.0"}
    req = urllib.request.Request(runs_url, headers=headers)
    
    try:
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode())
    except Exception as e:
        print(f"Error fetching runs: {e}")
        return
        
    runs = data.get("workflow_runs", [])
    if not runs:
        print("No runs found.")
        return
        
    # Get the latest run
    latest_run = runs[0]
    print(f"Latest Run: ID={latest_run['id']}, Event={latest_run['event']}, Status={latest_run['status']}, Conclusion={latest_run['conclusion']}")
    print(f"Commit: {latest_run['head_commit']['message']}")
    print(f"HTML URL: {latest_run['html_url']}")
    
    # Let's get the jobs for this run
    jobs_url = latest_run["jobs_url"]
    req_jobs = urllib.request.Request(jobs_url, headers=headers)
    
    try:
        with urllib.request.urlopen(req_jobs) as response:
            jobs_data = json.loads(response.read().decode())
    except Exception as e:
        print(f"Error fetching jobs: {e}")
        return
        
    jobs = jobs_data.get("jobs", [])
    for job in jobs:
        print(f"\nJob: {job['name']}, Status={job['status']}, Conclusion={job['conclusion']}")
        print("Steps:")
        for step in job.get("steps", []):
            print(f"  - {step['name']}: Status={step['status']}, Conclusion={step['conclusion']}")
            if step['conclusion'] == "failure":
                print(f"    >>> FAILED STEP: {step['name']}")
                
if __name__ == "__main__":
    main()
