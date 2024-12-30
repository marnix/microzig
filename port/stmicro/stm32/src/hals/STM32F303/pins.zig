const std = @import("std");
const comptimePrint = std.fmt.comptimePrint;
const StructField = std.builtin.Type.StructField;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

const gpio = @import("gpio.zig");

pub const Pin = enum {
    PE8,
    PE9,
    PE10,
    PE11,
    PE12,
    PE13,
    PE14,
    PE15,
    /// For now this is always a GPIO pin configuration
    pub const Configuration = struct {
        name: ?[:0]const u8 = null,
        mode: ?gpio.Mode = null,

        fn apply_to(self: @This(), pin: anytype) void {
            pin.configure(self);
        }
    };
};
fn GPIO(comptime port: []const u8, comptime num: []const u8, comptime mode: gpio.Mode) type {
    if (mode == .input) @compileError("TODO: implement GPIO input mode");
    return switch (mode) {
        .input => struct {
            const pin = gpio.Pin.init(port, num);

            pub inline fn read(_: @This()) u1 {
                return pin.read();
            }
        },
        .output => packed struct {
            const pin = gpio.Pin.init(port, num);

            pub inline fn put(_: @This(), value: u1) void {
                pin.put(value);
            }

            pub inline fn toggle(_: @This()) void {
                pin.toggle();
            }

            fn configure(_: @This(), pin_config: Pin.Configuration) void {
                _ = pin_config; // Later: use for GPIO pin speed etc.
                pin.configure();
            }
        },
    };
}

/// This is a helper empty struct with comptime constants for parsing an STM32 pin name.
/// Example: PinDescription("PE9").gpio_port_id = "E"
/// Example: PinDescription("PA12").gpio_port_number_str = "12"
fn PinDescription(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'H')
        @compileError(invalid_format_msg);

    const gpio_pin_number_int: comptime_int = std.fmt.parseInt(u4, spec[2..], 10) catch @compileError(invalid_format_msg);
    return struct {
        /// 'A'...'H'
        const gpio_port_id = spec[1..2];
        const gpio_pin_number_str = std.fmt.comptimePrint("{d}", .{gpio_pin_number_int});
    };
}

pub fn Pins(comptime config: GlobalConfiguration) type {
    comptime {
        var fields: []const StructField = &.{};
        for (@typeInfo(GlobalConfiguration).@"struct".fields) |port_field| {
            if (@field(config, port_field.name)) |port_config| {
                for (@typeInfo(Port.Configuration).@"struct".fields) |field| {
                    if (@field(port_config, field.name)) |pin_config| {
                        var pin_field = StructField{
                            .is_comptime = false,
                            .default_value_ptr = null,

                            // initialized below:
                            .name = undefined,
                            .type = undefined,
                            .alignment = undefined,
                        };

                        pin_field.name = pin_config.name orelse field.name;
                        const D = PinDescription(field.name);
                        pin_field.type = GPIO(D.gpio_port_id, D.gpio_pin_number_str, pin_config.mode orelse .{ .input = .floating });
                        pin_field.alignment = @alignOf(field.type);

                        fields = fields ++ &[_]StructField{pin_field};
                    }
                }
            }
        }

        return @Type(.{
            .@"struct" = .{
                .layout = .auto,
                .is_tuple = false,
                .fields = fields,
                .decls = &.{},
            },
        });
    }
}

pub const Port = enum {
    // TODO: Generate all ports
    GPIOE,

    // TODO: Generate all pins on all ports
    pub const Configuration = struct {
        PE8: ?Pin.Configuration = null,
        PE9: ?Pin.Configuration = null,
        PE10: ?Pin.Configuration = null,
        PE11: ?Pin.Configuration = null,
        PE12: ?Pin.Configuration = null,
        PE13: ?Pin.Configuration = null,
        PE14: ?Pin.Configuration = null,
        PE15: ?Pin.Configuration = null,

        fn apply_to(self: @This(), comptime pins: anytype, comptime gpio_port_name: []const u8) void {
            peripherals.RCC.AHBENR.modify_one(gpio_port_name ++ "EN", 1);
            // TODO: loop over all fields in self
            if (self.PE8) |pin_config| {
                pin_config.apply_to(pins.PE8);
            }
            if (self.PE9) |pin_config| {
                pin_config.apply_to(pins.PE9);
            }
            if (self.PE10) |pin_config| {
                pin_config.apply_to(pins.PE10);
            }
            if (self.PE11) |pin_config| {
                pin_config.apply_to(pins.PE11);
            }
            if (self.PE12) |pin_config| {
                pin_config.apply_to(pins.PE12);
            }
            if (self.PE13) |pin_config| {
                pin_config.apply_to(pins.PE13);
            }
            if (self.PE14) |pin_config| {
                pin_config.apply_to(pins.PE14);
            }
            if (self.PE15) |pin_config| {
                pin_config.apply_to(pins.PE15);
            }
        }
    };
};

pub const GlobalConfiguration = struct {
    // TODO: Generate all ports
    GPIOE: ?Port.Configuration = null,

    pub fn apply(comptime config: GlobalConfiguration) Pins(config) {
        const pins: Pins(config) = undefined; // Later: something seems incomplete here...
        // TODO: loop over all fields in config
        if (config.GPIOE) |port_config| {
            port_config.apply_to(pins, "GPIOE");
        }
        return pins;
    }
};
