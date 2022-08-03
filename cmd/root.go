package cmd

import (
	"fmt"
	"os"

	"github.com/chatton/homelab/cmd/portainer"
	"github.com/spf13/cobra"
)

func init() {
	rootCmd.AddCommand(portainer.NumbersCmd)
}

var rootCmd = &cobra.Command{
	Use:     "randx",
	Version: "1.0.1",
	Short:   "Returns random numbers or letters.",
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
