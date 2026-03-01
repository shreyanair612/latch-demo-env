# =============================================================================
# Network Security Group — GxP Validated Configuration
# Baseline: v3.2 (validated 2025-11-15)
# Environment: gxp-prod-eastus
# Regulation: 21 CFR Part 11.10(d)
# =============================================================================

resource "azurerm_network_security_group" "gxp_nsg" {
  name                = "network-security-gxp"
  location            = azurerm_resource_group.gxp_prod.location
  resource_group_name = azurerm_resource_group.gxp_prod.name

  # Allow HTTPS inbound from known CIDRs only
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }

  # Allow SSH from bastion only
  security_rule {
    name                       = "AllowSSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  }

  # Deny all other inbound traffic
  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "gxp-prod"
    compliance  = "21-CFR-Part-11"
    baseline    = "v3.2"
  }
}

# VELIRA AUTO-REMEDIATION — 2026-03-01T18:17:13.102611+00:00
# Drift detected: properties.securityRules[AllowPort8080].properties.access changed from None to Allow
# Severity: CRITICAL
# Regulation: 21 CFR Part 11.10(a)
# Action: Restore to GxP validated baseline v3.2
# Justification: Allowing port 8080 access in a validated production environment introduces a potential security vulnerability, compromising the confidentiality and integrity of electronic records.
