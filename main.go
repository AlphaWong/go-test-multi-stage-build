package main

import (
	"fmt"

	humanize "github.com/dustin/go-humanize"
)

func main() {
	fmt.Println("vim-go")
	fmt.Printf("You owe $%s.\n", humanize.Comma(6582491))
}
