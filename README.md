# Objetivos
Este repositório foi criado para estudar Kubernetes através do curso FullCycle. Para isso, desenvolvi uma aplicação em Golang e configurei vários ambientes no Kubernetes para essa aplicação: DEV (Desenvolvimento), QAA (Qualidade), HML (Homologação) e PRD (Produção).

# **Tutorial: Executando Kubernetes Localmente com Kind**

Neste tutorial, utilizaremos o [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/) para rodar o **Kubernetes** localmente. Vamos criar Pods da mesma aplicação em diferentes ambientes, a saber:

- DEV (Desenvolvimento)
- QAA (Qualidade e Automação)
- HML (Homologação)
- PRD (Produção)

## **Passo 1: Criar um Cluster Kubernetes**

Primeiro, vamos criar um cluster Kubernetes usando o Kind:

```powershell
kind create cluster --config=kind-cluster.yaml
```

## **Passo 2: Conectar o `kubectl` ao Cluster**

Em seguida, conecte o **`kubectl`** para interagir com o cluster recém-criado:

```powershell
kubectl cluster-info --context kind-kind-cluster
```

## **Passo 3: Adicionar Ingress ao Cluster**

Para permitir acesso externo aos Pods, adicionaremos o Ingress ao nosso cluster:

```powershell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

Espere até que o controlador do Ingress esteja pronto:

```powershell
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s
```

## **Passo 4: Criar Pods**

Agora, vamos realizar o deploy dos Pods para cada ambiente usando artefatos Deployment do Kubernetes:

```powershell
kubectl apply -f <ambiente>/deployment.yaml
```

Verifique a criação dos Pods:

```powershell
kubectl get pods
```

## **Passo 5: Criar Services**

Em seguida, realizaremos o deploy dos Services para cada ambiente usando artefatos Service do Kubernetes:

```powershell
kubectl apply -f <ambiente>/service.yaml
```

Verifique os Services criados:

```powershell
kubectl get svc
```

## **Passo 6: Criar ConfigMaps**

Em seguida, realizaremos o deploy dos ConfigMap para cada ambiente usando artefatos ConfigMap do Kubernetes:

```powershell
kubectl apply -f <ambiente>/configmap.yaml
```

Verifique os Services criados:

```powershell
kubectl get confimap
```

## **Passo 7: Criar o Ingress**

Agora, criaremos o recurso Ingress para roteamento das requisições:

```powershell
kubectl apply -f ingress.yaml
```

Verifique a criação do Ingress:

```powershell
kubectl get ingress
```

## **Passo 8: Testar os Pods**

Por fim, teste o acesso aos Pods em cada ambiente utilizando os seguintes links:

- [localhost/prd/info](http://localhost/prd/info)
- [localhost/dev/info](http://localhost/dev/info)
- [localhost/qaa/info](http://localhost/qaa/info)
- [localhost/hml/info](http://localhost/hml/info)

---

Este tutorial fornece uma visão geral clara e concisa de como configurar um ambiente Kubernetes local com diferentes ambientes usando o Kind. Certifique-se de ajustar os nomes dos arquivos **`<ambiente>/deployment.yaml`** e **`<ambiente>/service.yaml`** conforme necessário para cada ambiente específico.

# **Simulando o HPA no Kubernetes**

Este tutorial irá guiá-lo através do processo de simulação do Horizontal Pod Autoscaler (HPA) em um cluster Kubernetes. Vamos aplicar o HPA, realizar um teste de carga para aumentar o consumo de CPU e verificar a criação de novas réplicas de pods.

## **Passo 1: Aplicando o HPA no Cluster**

Primeiro, aplique o artefato HPA no seu cluster Kubernetes. Substitua **`<ambiente>`** pelo nome do seu ambiente.

```bash
kubectl apply -f <ambiente>/hpa.yaml
```

## **Passo 2: Verificando a Criação do HPA**

Após aplicar o HPA, verifique se ele foi criado corretamente:

```bash
kubectl get hpa
```

Você deve ver uma saída que mostra o HPA configurado no seu cluster.

## **Passo 3: Realizando um Teste de Carga com Fortio**

Para aumentar o consumo de CPU e "forçar" o HPA a adicionar mais réplicas de pods, utilizaremos o Fortio para realizar um teste de carga. Execute o seguinte comando:

```bash
kubectl run -it --rm --image=fortio/fortio fortio -- load -qps 800 -t 120s -c 10 "http://server-golang-<ambiente>/info"
```

- **`-qps 800`**: Define a taxa de requisições por segundo.
- **`-t 120s`**: Define a duração do teste para 120 segundos.
- **`-c 10`**: Define o número de conexões simultâneas.

## **Passo 4: Verificando o Aumento de Réplicas**

Após o teste de carga, aguarde alguns segundos e verifique se o HPA ajustou o número de réplicas conforme esperado.

### **Verificar o HPA**

Para verificar o estado atual do HPA:

```bash
kubectl get hpa
```

### **Verificar os Pods Criados**

Para ver quantos pods foram criados em resposta ao aumento de carga:

```bash
kubectl get pods
```

## **Conclusão**

Se tudo estiver configurado corretamente, você verá que o número de réplicas foi aumentado automaticamente pelo HPA para lidar com o aumento de carga. Este é um exemplo prático de como o HPA pode ajudar a gerenciar a escalabilidade de aplicações no Kubernetes.