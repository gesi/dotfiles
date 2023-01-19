function vscode_extension_to_nix_definition -a extension_id -a extension_version
  set publisher (string split '.' $extension_id)[1]
  set name (string split '.' $extension_id)[2]
  set hash (nix-prefetch-url  "https://$publisher.gallery.vsassets.io/_apis/public/gallery/publisher/$publisher/extension/$name/$extension_version/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage" 2>/dev/null)

  echo "{
  name = \"$name\";
  publisher = \"$publisher\";
  version = \"$version\";
  sha256 = \"$hash\";
}"
end