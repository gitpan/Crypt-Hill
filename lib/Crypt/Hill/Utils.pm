package Crypt::Hill::Utils;

$Crypt::Hill::Utils::VERSION = '0.03';

=head1 NAME

Crypt::Hill::Utils - Utils package for Crypt::Hill.

=head1 VERSION

Version 0.03

=cut

use 5.006;
use strict; use warnings;
use Data::Dumper;

use vars qw(@ISA @EXPORT @EXPORT_OK);

require Exporter;
@ISA       = qw(Exporter);
@EXPORT_OK = qw(generate_keys
                generate_table
                get_mod_inverse
                get_determinant
                multiply_mod);

=head1 DESCRIPTION

B<FOR INTERNAL USE ONLY>

=cut

sub generate_table {
    my ($chars) = @_;
    my $table   = {};
    my $index   = 0;

    foreach (@$chars) {
        $table->{$_} = $index++;
    }

    return $table;
}

sub get_mod_inverse {
    my ($determinant, $mod) = @_;

    $determinant %= $mod;
    for my $i (1..($mod-1)) {
        return $i if (($determinant * $i) % $mod == 1);
    }
}

sub get_determinant {
    my ($matrix) = @_;

    return (($matrix->[0][0] * $matrix->[1][1]) - ($matrix->[0][1] * $matrix->[1][0]));
}

sub multiply_mod {
    my ($matrix, $by, $mod) = @_;

    my $_matrix = [];
    $_matrix->[0][0]  = ($matrix->[0][0] * $by->[0][0] + $matrix->[0][1] * $by->[1][0]);
    $_matrix->[1][0]  = ($matrix->[1][0] * $by->[0][0] + $matrix->[1][1] * $by->[1][0]);
    $_matrix->[0][0] %= $mod;
    $_matrix->[1][0] %= $mod;

    return $_matrix;
}

sub generate_keys  {
    my ($charsets, $key, $size) = @_;

    my @keys = split //, $key;
    my $mod  = scalar(@keys) % $size;
    push @keys, _generate_random_characters($charsets, $mod) if ($mod > 0);

    return @keys;
}

#
#
# PRIVATE METHODS

sub _generate_random_number {
    my ($min, $max) = @_;

    return int($min + rand($max - $min));
}

sub _generate_random_characters {
    my ($charsets, $count) = @_;

    my @chars = @$charsets;
    my $min   = 1;
    my $max   = scalar(@chars);

    return @chars[ map { _generate_random_number($min, $max) } (1..$count) ];
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 REPOSITORY

L<https://github.com/Manwar/Crypt-Hill>

=head1 BUGS

Please report any bugs/feature requests to C<bug-crypt-hill at rt.cpan.org>  or
through the web interface at  L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Crypt-Hill>.
I will be notified & then you'll automatically be notified of progress on your bug
as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Crypt::Hill

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Crypt-Hill>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Crypt-Hill>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Crypt-Hill>

=item * Search CPAN

L<http://search.cpan.org/dist/Crypt-Hill/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2014 Mohammad S Anwar.

This  program  is  free software; you can redistribute it and/or modify it under
the  terms  of the the Artistic License (2.0). You may obtain a copy of the full
license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any  use,  modification, and distribution of the Standard or Modified Versions is
governed by this Artistic License.By using, modifying or distributing the Package,
you accept this license. Do not use, modify, or distribute the Package, if you do
not accept this license.

If your Modified Version has been derived from a Modified Version made by someone
other than you,you are nevertheless required to ensure that your Modified Version
 complies with the requirements of this license.

This  license  does  not grant you the right to use any trademark,  service mark,
tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge patent license
to make,  have made, use,  offer to sell, sell, import and otherwise transfer the
Package with respect to any patent claims licensable by the Copyright Holder that
are  necessarily  infringed  by  the  Package. If you institute patent litigation
(including  a  cross-claim  or  counterclaim) against any party alleging that the
Package constitutes direct or contributory patent infringement,then this Artistic
License to you shall terminate on the date that such litigation is filed.

Disclaimer  of  Warranty:  THE  PACKAGE  IS  PROVIDED BY THE COPYRIGHT HOLDER AND
CONTRIBUTORS  "AS IS'  AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES. THE IMPLIED
WARRANTIES    OF   MERCHANTABILITY,   FITNESS   FOR   A   PARTICULAR  PURPOSE, OR
NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY YOUR LOCAL LAW. UNLESS
REQUIRED BY LAW, NO COPYRIGHT HOLDER OR CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL,  OR CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE
OF THE PACKAGE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

1; # End of Crypt::Hill
