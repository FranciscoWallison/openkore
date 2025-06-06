package Network::CheckSum;

use strict;
use Exporter 'import';
use Globals qw($masterServer);

our @EXPORT_OK = qw(add_checksum);

sub add_checksum {
    my ($msg) = @_;
    if ($masterServer->{serverType} eq 'ROla') {
        my $crc = 0x00;
        for my $byte (unpack('C*', $msg)) {
            $crc ^= $byte;
            for (1..8) {
                if ($crc & 0x80) { $crc = (($crc << 1) ^ 0x07) & 0xFF; }
                else            { $crc = ($crc << 1) & 0xFF; }
            }
        }
        $msg .= pack('C', $crc);
    }
    return $msg;
}

1;

__END__
