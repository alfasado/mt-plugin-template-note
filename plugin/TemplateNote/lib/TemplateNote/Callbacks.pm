package TemplateNote::Callbacks;

use strict;
use warnings;

sub _cb_param_edit_template {
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

sub _cb_source_template_table {
    my ( $cb, $app, $tmpl ) = @_;
    my $append = '<mt:if name="note"><br /><span class="description"><mt:var name="note" escape="html"></span></mt:If>';
    $$tmpl =~ s!(<mt:var name="name" escape="html"><\/a>)!$1 $append!;
}

sub _cb_param_header {
    my ( $cb, $app, $param, $tmpl ) = @_;
    if ( my $mode = $app->mode ) {
        if ( $mode eq 'list_template' ) {
            my $component = MT->component( 'TemplateNote' );
            my $node = $tmpl->getElementsByName( 'html_head' );
            $node = @$node[ 0 ];
            $app->{ plugin_template_path } = File::Spec->catfile( $component->path,'tmpl' );
            my $attributes = { name => 'include/templatenote_header.tmpl' };
            my $insert = $tmpl->createElement( 'include', $attributes );
            $node->appendChild( $insert );
        }
    }
}

1;