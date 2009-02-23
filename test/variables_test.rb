require File.join(File.dirname(__FILE__), 'test_helper')

context "Querying for variables" do

  setup do
    @@variables_source ||= RbGCCXML.parse(full_dir("headers/classes.h")).namespaces("classes")
  end

  specify "find global variables and constants" do
    @@variables_source.variables.length.should == 2
  end

  specify "find class variables" do
    test1 = @@variables_source.classes("Test1")
    test1.variables.length.should == 4
    test1.variables.find(:access => :public).length.should == 2
    assert test1.variables("publicVariable")
    assert test1.variables("publicVariable2")
  end

  specify "can also find constants" do
    test1 = @@variables_source.classes("Test1")
    test1.constants.length.should == 1
    assert test1.constants("CONST") 
  end
end