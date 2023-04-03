require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Validation" do
    it "Si aucun Title n'est saisi, la Validation de la tâche est invalide." do
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Title can't be blank"]
    end

    it "Si aucun statut n'est saisi, la Validation de la tâche n'est pas valide." do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Status can't be blank"]
    end

    it "La validation de la tâche n'est pas valide si le délai d'achèvement n'a pas été saisi." do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: true)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline can't be blank"]
    end

    it "La validation d'une tâche n'est pas valide si la date limite d'achèvement est une date antérieure." do
      task = Task.new(title: "test", description: "test", status: :todo )
      expect(task.deadline).to be < Date.current
      expect(task.errors.full_messages).to eq ["Deadline should be grater"]

    end

    #it "La validation de la tâche est valide si la date limite d'achèvement est la date du jour." do
      #task = Task.new(title: "test", description: "test", status: :todo, deadline: must_start_from_today)
      #expect(task).to be_invalid
      #expect(task.errors.full_messages).to eq ["Deadline should be grater"]
    #end
  end
end