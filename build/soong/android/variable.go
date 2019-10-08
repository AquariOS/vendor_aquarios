package android

type Product_variables struct {
	Bootloader_message_offset struct {
		Cflags []string
	}

	Recovery_skip_ev_rel_input struct {
		Cflags []string
	}

	Should_wait_for_qsee struct {
		Cflags []string
	}

	Supports_hw_fde struct {
		Cflags []string
		Header_libs []string
		Shared_libs []string
	}
	Supports_hw_fde_perf struct {
		Cflags []string
	}
}

type ProductVariables struct {
	Bootloader_message_offset  *int `json:",omitempty"`
	Recovery_skip_ev_rel_input  *bool `json:",omitempty"`
	Should_wait_for_qsee  *bool `json:",omitempty"`
	Supports_hw_fde  *bool `json:",omitempty"`
	Supports_hw_fde_perf  *bool `json:",omitempty"`
}
