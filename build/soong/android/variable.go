package android

type Product_variables struct {
	Bootloader_message_offset struct {
		Cflags []string
	}
	Recovery_skip_ev_rel_input struct {
		Cflags []string
	}
}

type ProductVariables struct {
	Bootloader_message_offset  *int `json:",omitempty"`
	Recovery_skip_ev_rel_input  *bool `json:",omitempty"`
}
