package main

import (
	"github.com/conduitio/conduit/cmd/conduit/cli"
	"github.com/conduitio/conduit/pkg/conduit"
)

func main() {
	// Get the default configuration, including all built-in connectors
	cfg := conduit.DefaultConfig()

	cli.Run(cfg)
}
