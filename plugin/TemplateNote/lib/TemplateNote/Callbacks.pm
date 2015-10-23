package TemplateNote::Callbacks;

use strict;
use warnings;

sub _cb_mtappcmstemplate_param_edit_template {
    my ( $cb, $app, $param, $tmpl ) = @_;
    my $pointer_node = $tmpl->getElementById( 'template-body' );
    return unless $pointer_node;
    my $description_node = $tmpl->createElement( 'app:setting', {
        id => 'description',
        label => MT->translate( 'Note' ),
        show_label => 1,
        label_class => 'top-label'
    } );
    my $inner =<<'MTML';
        <input type="text" name="note" id="note" class="full-width" value="<mt:var name="note" escape="html">" />
MTML
    $description_node->innerHTML( $inner );
    $tmpl->insertAfter( $description_node, $pointer_node );
}

sub _cb_mtappcmstemplate_source_template_table {
    my ( $cb, $app, $tmpl ) = @_;
    my $append = '<mt:if name="note"><br /><span class="hint"><mt:var name="note" escape="html"></span></mt:If>';
    $$tmpl =~ s!(<mt:var name="name" escape="html"><\/a>)!$1 $append!;
    my $old = '<th\sclass="col\shead\stemplate-name\sprimary">';
    my $new = '<th class="col head template-name primary" style="width:65% !important">';
    $$tmpl =~ s!$old!$new!;
}

1;