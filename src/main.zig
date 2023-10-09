const std = @import("std");

pub fn main() !void {
    const address = std.net.Address.initIp4([4]u8{ 127, 0, 0, 1 }, 1337);

    var server = std.net.StreamServer.init(.{});
    defer server.deinit();

    try server.listen(address);
    std.debug.print("Listening...\n", .{});

    while (true) {
        const connection = try server.accept();
        defer connection.stream.close();

        std.debug.print("{} address connected to the server.\n", .{connection.address});
        _ = try connection.stream.write("Hi");
    }
}
