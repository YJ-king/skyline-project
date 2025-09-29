# 🛫 Terraform & Kubernetes 기반 항공 예약 시스템 인프라 구축

Terraform 모듈화를 통해 **Auto-Scaling이 가능한 AWS EKS 클러스터**를 구축하고, 그 위에 **Ingress, HPA, ConfigMap** 등 Kubernetes의 고급 기능을 활용하여 MSA 기반의 항공 예약 애플리케이션(Skyline)을 배포하는 프로젝트입니다.

---

## 🎯 프로젝트 목표
단순히 인프라를 구축하는 것을 넘어, **실제 운영(Production-Ready) 환경에 준하는 높은 수준의 자동화, 안정성, 확장성**을 갖춘 클라우드 인프라를 설계하는 것을 목표로 합니다. Terraform 모듈화를 통해 인프라의 재사용성을 확보하고, Kubernetes의 HPA와 Ingress를 통해 트래픽 변화에 유연하게 대응하며 안정적인 서비스를 제공하는 것을 핵심으로 합니다.

---

## 🏗️ 솔루션 아키텍처
본 아키텍처는 크게 두 단계로 구성됩니다.
1.  **인프라 프로비저닝 (Terraform):** 모듈화된 Terraform 코드를 실행하여 애플리케이션이 배포될 기반 환경인 VPC, Subnet, Security Group 및 EKS 클러스터를 AWS에 구축합니다.
2.  **애플리케이션 배포 (Kubernetes):** 구축된 EKS 클러스터 위에, **AWS Load Balancer Controller**를 먼저 설치합니다. 이후 애플리케이션 Manifest(Deployment, Service, Ingress 등)를 배포하여 외부 도메인과 서비스를 연결하고, 트래픽에 따라 Pod이 자동으로 확장되도록 구성합니다.

![Skyline Infrastructure Architecture](assets/architecture-skyline-iac.png)

---

## ✨ 핵심 구현 내용

### 1. Terraform 모듈화를 통한 IaC 구현
VPC, EKS 클러스터, IAM 역할 등 인프라의 각 기능 단위를 독립적인 모듈로 분리하여 코드의 재사용성과 관리 효율성을 극대화했습니다.
* **`vpc` 모듈:** Multi-AZ를 고려한 고가용성 네트워크 환경을 담당합니다.
* **`eks` 모듈:** 관리형 쿠버네티스 클러스터와 Auto Scaling Group 기반의 노드 그룹을 담당합니다.
* **`iam` 모듈:** EKS 운영 및 AWS 리소스 접근에 필요한 IAM 역할과 정책을 담당합니다.

### 2. Kubernetes를 활용한 고급 애플리케이션 배포
단순 배포를 넘어, 실제 서비스 운영에 필수적인 고급 기능들을 적용했습니다.

* **Ingress를 통한 도메인 연결:**
    * **AWS Load Balancer Controller**를 클러스터에 배포하여 **Application Load Balancer(ALB)**가 Ingress 리소스를 통해 자동으로 관리되도록 구성했습니다.
    * 이를 통해 `skyline.yjking.shop`과 같은 **사용자 정의 도메인**으로 들어오는 트래픽을 L7 레벨에서 적절한 서비스로 라우팅할 수 있습니다.

* **HPA (Horizontal Pod Autoscaler)를 이용한 자동 확장:**
    * 사용자의 트래픽 증가로 **Pod의 CPU 사용률이 50%를 초과**하면, **자동으로 Pod의 수를 최대 10개까지 늘리도록** HPA를 설정했습니다.
    * 이를 통해 갑작스러운 트래픽 급증에도 안정적인 서비스 성능을 유지할 수 있습니다.

* **ConfigMap을 통한 설정 분리:**
    * 데이터베이스 엔드포인트, 외부 API 주소 등 자주 변경될 수 있는 설정 값들을 애플리케이션 코드에서 분리하여 **ConfigMap**으로 관리합니다.
    * 이를 통해 애플리케이션 이미지를 다시 빌드하지 않고도 설정을 유연하게 변경하고, 다양한 환경(dev, prod)에 동일한 애플리케이션을 쉽게 배포할 수 있습니다.

---

## 🛠️ 기술 스택
-   **Cloud:** AWS (EKS, EC2, VPC, IAM, ALB)
-   **IaC:** Terraform (Modular Architecture)
-   **Container & Orchestration:** Docker, Kubernetes (Ingress, HPA, ConfigMap)
-   **Ingress Controller:** AWS Load Balancer Controller
-   **Application:** Skyline Airline Booking System (Demo)

---

## 🚀 배포 방법
1.  **AWS 자격 증명 설정:** 로컬 환경에 AWS CLI를 설정하고 자격 증명을 구성합니다.
2.  **Terraform 초기화 및 배포:** `terraform` 디렉토리에서 `terraform init` 후 `terraform apply`를 실행하여 EKS 클러스터를 생성합니다.
3.  **kubectl 설정:** 생성된 EKS 클러스터에 접근할 수 있도록 `kubeconfig`를 업데이트합니다.
4.  **AWS Load Balancer Controller 배포:** EKS 클러스터에 AWS Load Balancer Controller를 설치합니다.
5.  **애플리케이션 배포:** `kubectl apply -f k8s/` 명령어를 실행하여 Ingress를 포함한 모든 애플리케이션 리소스를 배포합니다.

---

## 💡 배운 점 및 회고
이번 프로젝트를 통해 Terraform 모듈화로 잘 설계된 인프라를 구축하는 경험을 넘어, Kubernetes의 핵심 기능들을 활용하여 **'스스로 살아 움직이는(Self-healing & Self-scaling)' 인프라**를 만드는 심화 과정을 경험할 수 있었습니다. 특히 Ingress를 통해 도메인을 연결하고, HPA로 트래픽에 따라 Pod이 자동으로 늘어나는 것을 보며 클라우드 네이티브의 진정한 강력함을 체감했습니다.

**Next Step:** 현재는 기본적인 CI(Continuous Integration)만 구성되어 있지만, **Argo CD와 같은 GitOps 툴**을 도입하여 Kubernetes 배포까지 완전히 자동화하고 싶습니다. GitHub Repository의 Manifest 변경 사항이 자동으로 클러스터에 동기화되는 파이프라인을 구축하여, 인프라부터 애플리케이션까지 End-to-End 자동화를 완성하는 것이 다음 목표입니다.