module "nsg-hereford" {
  source         = "./modules/new-nsg"
  compartment_id = var.BU-Corp-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-hereford"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 3389
      max_port    = 3389
      description = "RDP from VPN admin"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-cannes
      min_port    = 3389
      max_port    = 3389
      description = "RDP from VPN common"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 443
      max_port    = 443
      description = "UI from VPN admin"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-cannes
      min_port    = 443
      max_port    = 443
      description = "UI from VPN common"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Cliente OpenAPI para transmissão de visualização ao vivo e reprodução"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 559
      max_port    = 559
      description = "Cliente Web para transmissão em Google Chrome, Firefox ou Safari (WebSocket)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 554
      max_port    = 554
      description = "Cliente Web para transmissão de visualização ao vivo (RTMP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 1935
      max_port    = 1935
      description = "Cliente OpenAPI para transmissão de visualização ao vivo (RTMP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6011
      max_port    = 6011
      description = "Porta de redirecionamento para enviar dados via HTTP"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6021
      max_port    = 6021
      description = "Usada para login."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6022
      max_port    = 6022
      description = "Usada para aplicar agendamento de gravação."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6027
      max_port    = 6027
      description = "Usada para gravar dados de vídeo."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6036
      max_port    = 6042
      description = "Usada para encaminhar, transmitir e baixar dados de vídeo e armazenamento"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6044
      max_port    = 6046
      description = "Usada para encaminhar, transmitir e baixar dados de objeto e armazenamento"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6060
      max_port    = 6060
      description = "Usada para transmitir dados da web"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6098
      max_port    = 6098
      description = "Usada para reproduzir dados de mídia do servidor de streaming de mídia"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6111
      max_port    = 6111
      description = "Porta de redirecionamento para enviar dados via HTTPS"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6111
      max_port    = 6114
      description = "Porta de redirecionamento, enviar e baixar dados via HTTPS"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6120
      max_port    = 6120
      description = "Porta de redirecionamento para baixar dados via HTTP"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6201
      max_port    = 6201
      description = "Porta de comunicação para armazenamento de objeto"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6470
      max_port    = 6471
      description = "Terminal de Sinalização Digital para atualização de terminais e liberação de programas"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6678
      max_port    = 6678
      description = "SYS para configuração do Servidor de Transmissão (HTTPS)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 7332
      max_port    = 7332
      description = "Dispositivos ISUP para recepção de alarmes (TCP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "17"                            // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 7334
      max_port    = 7334
      description = "Dispositivos ISUP para recepção de alarmes (UDP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 7660
      max_port    = 7664
      description = "Servidor de Transmissão para obtenção de transmissão de dispositivo ISUP (TCP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 8555
      max_port    = 8555
      description = "Dispositivos ISUP para transferência de arquivos e download de imagens (TCP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 8686
      max_port    = 8686
      description = "Terminal de Orientação para escuta de alarmes (TCP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 8877
      max_port    = 8877
      description = "Alto-falantes IP para registro via protocolo Hikvision (TCP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 9980
      max_port    = 9980
      description = "Terminal de Sinalização Digital para upload de materiais (HTTP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 10015
      max_port    = 10015
      description = "Alto-falantes IP para transmissão de dados de áudio via protocolo Hikvision (TCP)."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 14200
      max_port    = 14200
      description = "Site Remoto para registro no Sistema Central (HTTP/HTTPS)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 15300
      max_port    = 15300
      description = "Sistema de Terceiros para recepção de eventos genéricos (TCP/UDP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 15310
      max_port    = 15310
      description = "Sistema de Terceiros para recepção de eventos genéricos (HTTP)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 15443
      max_port    = 15443
      description = "Sistema de Terceiros para recepção de eventos genéricos (HTTPS)"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-h7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 16000
      max_port    = 16003
      description = "Dispositivo ISUP e Clientes Web para obtenção de transmissão via plugin (TCP"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                         // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"    // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-hunderton.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Opening all ports from hunderton instance"
    }
  ]
}

output "nsg_id" {
  value = module.nsg-hereford.nsg_id
}
