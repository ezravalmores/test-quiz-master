require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
   
  context "questions controller specs" do
    let(:question) { FactoryGirl.create :question }   
   
    it "should get index" do
      get :index 
      expect(assigns(:questions)).to eq([question])
    end

    it "should assign @answers" do
      dummy_params = { answer: {answer: "foobar"}, id: question.id }
      post "answer", dummy_params
      expect(assigns(:answer)).to_not be_nil 
    end
    
    it "expect if question successfully updated" do
      dummy_params = { answer: "foo", answer: "Bar" }
      
      put :update, id: question.id, question: dummy_params 
      expect(response).to redirect_to :root
    end
    
    it "expect if question successfully created" do 
      expect{
        put :create, question: FactoryGirl.attributes_for(:question)
      }.to change(Question, :count).by(1)
    end

  end
end
