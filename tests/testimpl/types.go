package common

import (
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
)

type ThisTFModuleConfig struct {
	types.GenericTFModuleConfig
	Zones   map[string]Zones `json:"zones"`
	Records []Records        `json:"records"`
}

type Zones struct {
	Domain_name   string            `json:"domain_name"`
	Comment       string            `json:"comment"`
	Force_destroy bool              `json:"force_destroy"`
	Tags          map[string]string `json:"tags"`
	Vpc           map[string]Vpc    `json:"vpc"`
}

type Vpc struct {
	Vpc_id     string `json:"vpc_id"`
	Vpc_region string `json:"vpc_region"`
}

type Records struct {
	Alias   Alias    `json:"alias"`
	Name    string   `json:"name"`
	Records []string `json:"records"`
	TTL     int64    `json:"ttl"`
	Type    string   `json:"type"`
}

type Alias struct {
}
