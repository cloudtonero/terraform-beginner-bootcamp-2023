// package main: Declares the package name
// The main package is special in Go, Its where the eecution of the program starts 

package main

// import "fmt": imports the fmt package, which contains functions for the formatted I/O
import (
	"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	//"github.com/google/uuid" // Import the Go UUID 
	//"log"
)
// func main() {: This line defines the main function. In Go, 
//the main function is the entry point of the program. It's where the program execution begins.
func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
		
	})
	// format.printline
	//prints the standout output
	fmt.Println("hello, world!")
}
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{

		},
		DataSourcesMap: map[string]*schema.Resource{

		},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for hte external service",
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true, // mark the token as sensitive to hide it in the logs
				Required: true,
				Description: "The bearer token for authorization",
			},
			"user_uud": {
				Type: schema.TypeString,
				Required: true,
				Description: "The UUID for configuration",
				//ValidateFunc: validateUUID,
			},
		},

	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p
}

// func validateUUID(v interface{}, k string) (ws []string, errors []error) {
//     log.Print('validateUUID:start')
// 	value := v.(string)
// 	if _,err = uuid.parse(value); err != nil {
// 		errors = append(error, fmt.Error("Invalid UUID format"))
// 	}
// 	log.Print('validateUUID:end')
// }