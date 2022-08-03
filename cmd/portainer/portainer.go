package portainer

import (
	"fmt"

	"github.com/spf13/cobra"
)

var (
	countFlagNumbers int
	rangeFlagNumbers []string
)
var NumbersCmd = &cobra.Command{
	Use:   "numbers",
	Short: "Returns random numbers",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("numbers mode")
		fmt.Println("--count:", countFlagNumbers)
		fmt.Println("--range:", rangeFlagNumbers)
	},
}
