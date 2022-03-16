const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");

pub fn I2CController(comptime index: usize) type {
    const SystemI2CController = chip.I2CController(index);

    const I2CDevice = struct {
        const Device = @This();

        internal: SystemI2CController,
        address: u7,

        const Direction = enum { read, write };
        fn Transfer(comptime direction: Direction) type {
            return switch (direction) {
                .read => struct {
                    const Self = @This();

                    state: SystemI2CController.ReadState,

                    pub const Reader = std.io.Reader(*Self, ReadError, readSome);

                    pub fn reader(self: *Self) Reader {
                        return Reader{ .context = self };
                    }

                    fn readSome(self: *Self, buffer: []u8) ReadError!usize {
                        try self.state.readNoEof(buffer);
                        return buffer.len;
                    }

                    /// STOP the transfer, invalidating this object.
                    pub fn stop(self: *Self) void {
                        self.state.stop();
                    }

                    /// RESTART to a new transfer, invalidating this object.
                    pub fn restartTransfer(self: *Self, comptime new_direction: Direction) !Transfer(new_direction) {
                        return Transfer(direction){ .state = try self.state.restartTransfer(new_direction) };
                    }
                },
                .write => struct {
                    const Self = @This();

                    state: SystemI2CController.WriteState,

                    pub const Writer = std.io.Writer(*Self, WriteError, writeSome);

                    pub fn writer(self: *Self) Writer {
                        return Writer{ .context = self };
                    }

                    fn writeSome(self: *Self, buffer: []const u8) WriteError!usize {
                        try self.state.writeAll(buffer);
                        return buffer.len;
                    }

                    /// STOP the transfer, invalidating this object.
                    pub fn stop(self: *Self) void {
                        self.state.stop();
                    }

                    /// RESTART to a new transfer, invalidating this object.
                    pub fn restartTransfer(self: *Self, comptime new_direction: Direction) !Transfer(new_direction) {
                        return switch (new_direction) {
                            .read => Transfer(new_direction){ .state = try self.state.restartRead() },
                            .write => Transfer(new_direction){ .state = try self.state.restartWrite() },
                        };
                    }
                },
            };
        }

        /// START a new transfer
        pub fn startTransfer(self: Device, comptime direction: Direction) !Transfer(direction) {
            return switch (direction) {
                .read => Transfer(direction){ .state = try SystemI2CController.ReadState.start(self.address) },
                .write => Transfer(direction){ .state = try SystemI2CController.WriteState.start(self.address) },
            };
        }

        /// Shorthand for 'register-based' devices
        pub fn readRegister(self: Device, register_address: u8) ReadError!u8 {
            var buffer: [1]u8 = undefined;
            try self.readRegisters(register_address, &buffer);
            return buffer[0];
        }

        /// Shorthand for 'register-based' devices
        pub fn readRegisters(self: Device, register_address: u8, buffer: []u8) ReadError!void {
            var rt = write_and_restart: {
                var wt = try self.startTransfer(.write);
                errdefer wt.stop();
                try wt.writer().writeByte(1 << 7 | register_address); // MSB == 'keep sending until I STOP'
                break :write_and_restart try wt.restartTransfer(.read);
            };
            defer rt.stop();
            try rt.reader().readNoEof(buffer);
        }
    };

    return struct {
        const Self = @This();

        internal: SystemI2CController,

        pub fn init() InitError!Self {
            return Self{
                .internal = try SystemI2CController.init(),
            };
        }

        pub fn device(self: Self, address: u7) I2CDevice {
            return I2CDevice{ .internal = self.internal, .address = address };
        }
    };
}

pub const InitError = error{};
pub const WriteError = error{};
pub const ReadError = error{
    EndOfStream,
    TooFewBytesReceived,
    TooManyBytesReceived,
};
