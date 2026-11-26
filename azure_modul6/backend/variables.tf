
variable "kortnavn" {
  description = <<-EOT
    Ditt unike kortnavn. Små bokstaver og tall, 3–8 tegn.
    Den havner rett inn i et storage account-navn ("stdemo" + kortnavn), og
    det er derfor grensene er strammere her enn i øving 4. Et storage
    account-navn må være 3–24 tegn, kun små alfanumeriske, og globalt unikt i
    hele Azure.
  EOT
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,8}$", var.kortnavn))
    error_message = "kortnavn må være 3–8 tegn, kun små bokstaver og tall."
  }
}

variable "location" {
  description = "Azure-region backenden opprettes i. Bruk samme region som i nettverksprosjektet."
  type        = string
  default     = "norwayeast"

  validation {
    condition     = contains(["norwayeast", "westeurope", "northeurope", "uksouth"], var.location)
    error_message = "Regionen må være én av: norwayeast, westeurope, northeurope, uksouth (Azure Policy i fagets tenant)."
  }
}

variable "pipeline_principal_id" {
  description = <<-EOT
    OBJECT-IDen til SERVICE PRINCIPAL-EN bak App Registration-en din.
    Tre IDer forveksles her, og bare én av dem er riktig:
      Application (client) ID  – identifiserer App Registration-en (definisjonen)
      Object ID på Overview    – tilhører App Registration-OBJEKTET
      Object ID på service     – DENNE. Rolletildelinger peker alltid hit.
        principal-en
    Hentes slik, innlogget mot fagets tenant:
      az ad sp list --display-name "<dinAppName>" --query "[].id" --output tsv
    og kontrolleres slik:
      az ad sp show --id <client-id> --query id -o tsv
  EOT
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.pipeline_principal_id))
    error_message = "pipeline_principal_id må være en GUID (36 tegn). Se beskrivelsen for hvordan du finner riktig verdi."
  }
}

locals {
  tags = {
    student = var.kortnavn
    course  = "iac"
    keep    = "true"
  }
}