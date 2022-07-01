# awscloudwatchagent
Container service with awscloudwatchagent

### 목적 : Container 내의 특정 폴더에 생성되는 로그파일을 CloudWatch log로 전달하는 image 생성 방법
### 방법 : CloudWatch agent config 파일을 설정하고 이를 이용하여 container용 agent를 실행.

1. amazon-cloudwatch-agent-ctl을 이용하여 local 설정한 config를 agent가 인식하는 config 파일로 전환하기 
   /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/home/ec2-user/cwagent_config.json -s
2. 1번 작업으로 생성된 /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml 파일을 /home/ec2-user 로 복사한 후 Container 환경에 맞추어 수정하기
3. /home/ec2-user/amazon-cloudwatch-agent.toml 에서 수정한 내용은 sed 를 이용해 container 내에서 치환할 예약 문자열로 수정.
4. 1번 작업으로 생성된 /opt/aws/amazon-cloudwatch-agent/etc/env-config.json 파일을 /home/ec2-user로 복사한 후 추가 작업 없음.
5. /home/ec2-user/run_apps_script.sh 내용 중 sed 구문의 치환 정보를 목적에 맞게 수정/추가하기
6. docker build 하고, 실행 테스트하기 (docker run -d .... )

### 참고사항 : amazon-cloudwatch-agent container가 기동하고 최초 CloudWatch log그룹과 로그는 5분정도 지연되어 생성됨. 
             그 이후는 설정한 주기기준으로 변경되는 로그 정보를 수집해 온다.
