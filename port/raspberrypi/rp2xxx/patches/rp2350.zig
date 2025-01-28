pub const patches = &.{
    .{
        .add_enum = .{
            .parent = "types.peripherals.USB_DPRAM",
            .@"enum" = .{
                .name = "EndpointType",
                .bitsize = 2,
                .fields = &.{
                    .{ .value = 0x0, .name = "control" },
                    .{ .value = 0x1, .name = "isochronous" },
                    .{ .value = 0x2, .name = "bulk" },
                    .{ .value = 0x3, .name = "interrupt" },
                },
            },
        },
    },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP1_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP1_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP2_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP2_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP3_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP3_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP4_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP4_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP5_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP5_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP6_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP6_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP7_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP7_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP8_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP8_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP9_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP9_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP10_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP10_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP11_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP11_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP12_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP12_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP13_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP13_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP14_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP14_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP15_IN_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
    .{ .set_enum_type = .{ .of = "types.peripherals.USB_DPRAM.EP15_OUT_CONTROL.ENDPOINT_TYPE", .to = "types.peripherals.USB_DPRAM.EndpointType" } },
};
