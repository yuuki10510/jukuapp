class Score < ApplicationRecord
  belongs_to :student, class_name: "User"

  enum :subject, {
    math: 0,
    english: 1,
    japanese: 2,
    science: 3,
    social: 4
  }

  enum :test_type, {
    regular: 0,
    mock: 1
  }

  enum :term, {
    first_mid: 0,
    first_end: 1,
    second_mid: 2,
    second_end: 3,
    third_mid: 4,
    year_end: 5
  }

  validates :subject, :score, :test_type, :term, presence: true
  validates :subject,
    uniqueness: {
      scope: [:student_id, :term, :test_type],
      message: "はすでに登録されています"
    }

  # テスト表示順
  TEST_ORDER = [
    [:first_mid,  :regular],
    [:first_end,  :regular],
    [:second_mid, :regular],
    [:second_end, :regular],
    [:third_mid,  :regular],
    [:year_end,   :regular]
  ].freeze

  def self.subjects_i18n
    subjects.keys.index_with do |key|
      I18n.t("activerecord.enums.score.subject.#{key}")
    end
  end

  def self.test_types_i18n
    test_types.keys.index_with do |key|
      I18n.t("activerecord.enums.score.test_type.#{key}")
    end
  end

  def self.terms_i18n
    terms.keys.index_with do |key|
      I18n.t("activerecord.enums.score.term.#{key}")
    end
  end

  # ===== 一覧表示用（インスタンスメソッド） =====
  def subject_i18n
    I18n.t("activerecord.enums.score.subject.#{subject}")
  end

  def test_type_i18n
    I18n.t("activerecord.enums.score.test_type.#{test_type}")
  end

  def term_i18n
    I18n.t("activerecord.enums.score.term.#{term}")
  end

  # テスト単位（term + test_type）で合計点を返す
  def self.total_scores_by_test(scores)
    scores
     .group(:term, :test_type)
     .sum(:score)
     .transform_keys { |k| [k[0].to_s, k[1].to_s] }
  end
  
  def self.build_line_chart_data(scores)
    totals = total_scores_by_test(scores)

    data = {}

    TEST_ORDER.each do |term, test_type|
      label = I18n.t("activerecord.enums.score.term.#{term}")

      data[label] = totals[[term.to_s, test_type.to_s]] || 0
    end

    data
  end
end
