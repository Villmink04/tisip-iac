config {
  format = "compact" # én linje per funn
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "azurerm" {
  enabled = true
  version = "0.32.0" # pinnet – samme regler lokalt og i CI
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# Slå PÅ en regel som ikke er med i presettet
rule "terraform_naming_convention" {
  enabled = true # etiketter i snake_case: "min_vm", ikke "minVM"
}

# Slå AV en regel som ikke passer i vår kontekst
rule "azurerm_linux_virtual_machine_retired_size" {
  enabled = false # Standard_B1s er fagets policy-valg
}