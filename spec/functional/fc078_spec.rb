require "spec_helper"

describe "FC078" do
  context "with a cookbook with a metadata file that specifies" do
    context "a license generated by knife cookbook create" do
      metadata_file "license 'Apache 2.0'"
      it { is_expected.to violate_rule }
    end

    context "a license generated by chef generate cookbook" do
      metadata_file "license 'apache_2'"
      it { is_expected.to violate_rule }
    end

    context "a valid OSI-approved open source license in SPDX format" do
      metadata_file "license 'Apache-2.0'"
      it { is_expected.to_not violate_rule }
    end

    context "ChefDK's non-SPDX all rights reserved string" do
      metadata_file "license 'All Rights Reserved'"
      it { is_expected.to violate_rule }
    end

    context "a license with parens" do
      metadata_file "license('Apache-2.0')"
      it { is_expected.to_not violate_rule }
    end

    context "no license" do
      metadata_file
      it { is_expected.to violate_rule }
    end
  end
end
