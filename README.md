# gcp_simple_compute_engine_sample
GCPのCompute Engineインスタンスを構築する。

- 東京リージョンのみのネットワーク (asia-northeast1)
- 外部IPを持たないCompute Engineインスタンス
  - Debian 10イメージ
- FirewallでSSH/RDPのみ許可
  - Cloud IAPによるSSHのトンネル接続設定をしているので、外部IPがなくても `gcloud ssh` でSSH接続可能

# 準備

## サービスアカウントキーを発行する

デプロイ先のプロジェクトにてサービスアカウントキーを発行し、gcp_terraformディレクトリ配下に置く
ここではキー名を `<SA_KEY_NAME>.json` とする。

以下のように環境変数を設定する。

```
export GOOGLE_APPLICATION_CREDENTIALS=<SA_KEY_NAME>.json
```

## Cloud Storage バケットを作る

デプロイ先のプロジェクトにてtfstateファイル保存用のCloud Storageバケットを作成する。
バケット名は全GCP環境内で一意のものを指定する。ここではバケット名を`<TFSTATE-BUCKET>`とする。

## backend.tf を作成する

`gcp_terraform/backend.tf` を作成する。ここで `prefix` ブロックは任意で設定する。

```
terraform {
  backend "gcs" {
    bucket      = "<TFSTATE-BUCKET>"
    prefix      = "terraform/state"
  }
}
```

## variables.tfvars を作成する

以下の変数の値を指定する。

- **project-name**: GCPプロジェクト名
- **project-code**: このTerraformファイルで構築されるリソースに付与するプレフィクス

`gcp_terraform/variable.tfvars` を作成して上記変数の値を指定する。

```
project-name = "<YOUR-PROJECT-NAME>"
project-code = "<YOUR-PROJECT-CODE>"
```

# デプロイ

初回は以下コマンドを順に実行する。

```
cd gcp_terraform
terraform init
terraform validate
terraform plan -var-file=variable.tfvars
terraform apply -var-file=variable.tfvars
```

2回目以降は以下コマンドを実行する

```
cd gcp_terraform
terraform validate
terraform plan -var-file=variable.tfvars
terraform apply -var-file=variable.tfvars
```

# 環境削除

以下コマンドを実行する

```
cd gcp_terraform
terraform destroy
```

Cloud Storage バケット `<TFSTATE-BUCKET>` をコンソールで削除する。