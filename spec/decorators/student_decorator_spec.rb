require 'rails_helper'

describe StudentDecorator do
  let(:teacher) { create :teacher, first_name: 'John', last_name: 'Smith' }
  let(:student) { create :student, first_name: 'John', last_name: 'Smith', start_date: "2014-10-01"  }
  let(:student_with_birthdate) { create :student, first_name: 'John', last_name: 'Smith', birthdate: "2001-04-09" }
  let(:ex_student) { create :student, first_name: 'John', last_name: 'Smith', start_date: "2014-10-01", end_date: "2015-02-01" }
  let(:subject_item) { create :subject_item, teacher: teacher }
  let(:second_subject_item) { create :subject_item }
  let!(:note_1) { create :subject_item_note, value: 5, student: student, subject_item: second_subject_item }
  let!(:note_2) { create :subject_item_note, value: 4, student: student, subject_item: second_subject_item }

  describe "#full_name" do
    subject { student.decorate.full_name }
    it { is_expected.to eq 'John Smith' }
  end

  describe "#birthdate" do
    describe "when student doesn't have birthdate filled" do
      subject { student.decorate.birthdate_formated }
      it { is_expected.to eq nil }
    end

    describe "when student has birthdate filled" do
      subject { student_with_birthdate.decorate.birthdate_formated }
      it { is_expected.to eq '2001-04_09' }
    end
  end

  describe "#avg_notes" do
    describe "when student doesn't have notes assigned" do
      subject { student.decorate.avg_notes(subject_item) }

      it "returns 0.00" do
        is_expected.to eq '0.00'
      end
    end

    describe 'when student has notes assigned' do
      subject { student.decorate.avg_notes(second_subject_item) }

      it 'calculates avg of student notes' do
        is_expected.to eq '4.50'
      end
    end

    describe "#in_debt?" do
      describe "when student doesn't study anymore" do
        subject { ex_student.in_debt? }

        it "returns true" do
          is_expected.to eq true
        end
      end

      describe 'when student still study' do
        subject { student.in_debt? }

        it "returns true" do
          is_expected.to eq true
        end
      end
    end

  end
end
