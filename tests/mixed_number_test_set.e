note
	description: "[
		Tests of {MIXED_NUMBER}.
		]"
	warning: "[
		The {MIXED_NUMBER} class cannot represent mixed number between 0 and -1.
		]"
	testing: "type/manual"

class
	MIXED_NUMBER_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	make_test
			-- New test routine
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.make (False, 5, 3, 4)
			assert ("valid_whole_part", l_mixed.whole_part = 5)
			assert ("valid_numerator", l_mixed.numerator = 3)
			assert ("valid_denominator", l_mixed.denominator = 4)
			assert ("valid_is_negative", not l_mixed.is_negative)
		end

	make_with_improper_fraction_test
			-- Test with an improper mixed number fraction (e.g. 5 65/32 = 7 1/32)
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.make (False, 5, 65, 32)
			assert ("whole_part_is_7", l_mixed.whole_part = (7).to_natural_64)
			assert ("numerator_is_1", l_mixed.numerator = (1).to_natural_64)
			assert ("denominator_is_32", l_mixed.denominator = (32).to_natural_32)
			assert ("sign_is_1", l_mixed.sign = 1)
			create l_mixed.make (False, 0, 65, 32)
			assert ("whole_part_is_2", l_mixed.whole_part = (2).to_natural_64)
			assert ("numerator_is_1", l_mixed.numerator = (1).to_natural_32)
			assert ("denominator_is_32", l_mixed.denominator = (32).to_natural_32)
			assert ("sign_is_1", l_mixed.sign = 1)
			create l_mixed.make (True, 5, 65, 32)
			assert ("whole_part_is_7_2", l_mixed.whole_part = (7).to_natural_64)
			assert ("is_negative", l_mixed.is_negative)
			assert ("numerator_is_1", l_mixed.numerator = (1).to_natural_32)
			assert ("denominator_is_32", l_mixed.denominator = (32).to_natural_32)
			assert ("sign_is_neg_1", l_mixed.sign = -1)
		end

	make_from_integer_32_test
			-- Test `make_from_integer_32'.
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.make_from_integer_32 ((-5).as_integer_32)
			assert ("valid_whole_part", l_mixed.whole_part = (5).to_natural_64)
			assert ("valid_numerator", l_mixed.numerator = 0)
			assert ("valid_denominator", l_mixed.denominator = 1)
			assert ("whole_number", l_mixed.is_whole_number)
			assert ("is_negative", l_mixed.is_negative)
		end

	make_from_integer_64_test
			-- Test `make_from_integer_64'.
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.make_from_integer_64 ((5).as_integer_64)
			assert ("valid_whole_part", l_mixed.whole_part = (5).to_natural_64)
			assert ("valid_numerator", l_mixed.numerator = 0)
			assert ("valid_denominator", l_mixed.denominator = 1)
			assert ("whole_number", l_mixed.is_whole_number)
			assert ("not_is_negative", not l_mixed.is_negative)
		end

feature -- Tests

	sign_test
			-- Test `sign'
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.make (False, 0, 0, 1)
			assert ("sign_is_0", l_mixed.sign = 0)
			create l_mixed.make (False, 0, 1, 2)
			assert ("sign_is_1", l_mixed.sign = 1)
			create l_mixed.make (True, 5, 1, 2)
			assert ("sign_is_minus_1", l_mixed.sign = -1)
		end

	is_less_test
			-- Test `is_less'
		note
			testing:  "run/checkin/regular"
		local
			l_mixed_1, l_mixed_2: MIXED_NUMBER
		do
			create l_mixed_1.make (False, 5, 3, 4)
			create l_mixed_2.make (False, 3, 5, 4)
			assert ("is_less_1", l_mixed_2 < l_mixed_1)
			assert ("not_is_less_1", not (l_mixed_1 < l_mixed_2))
			create l_mixed_2.make (True, 5, 3, 4)
			assert ("neg_is_less_1", l_mixed_2 < l_mixed_1)
			assert ("neg_not_is_less_1", not (l_mixed_1 < l_mixed_2))
			create l_mixed_2.make (False, 0, 3, 4)
			assert ("zero_is_less_1", l_mixed_2.zero < l_mixed_2)
			create l_mixed_2.make (False, 5, 3, 4)
			assert ("not_is_less_2", not (l_mixed_1 < l_mixed_2))
			create l_mixed_2.make (False, 5, 3, 8)
			assert ("is_greater_1", (l_mixed_1 > l_mixed_2))
		end

	is_equal_test
			-- Test `is_equal'
		note
			testing:  "run/checkin/regular"
		local
			l_mixed_1, l_mixed_2: MIXED_NUMBER
		do
			create l_mixed_1.make (False, 5, 3, 4)
			create l_mixed_2.make (False, 3, 5, 4)
			assert ("not_is_equal_1", not l_mixed_2.is_equal (l_mixed_1))
			create l_mixed_2.make (True, 5, 3, 4)
			assert ("neg_is_equal_1", not l_mixed_2.is_equal (l_mixed_1))
			create l_mixed_2.make (False, 0, 3, 4)
			assert ("zero_is_equal_1", not l_mixed_2.zero.is_equal (l_mixed_2))
			create l_mixed_2.make (False, 5, 3, 4)
			assert ("is_equal", l_mixed_1.is_equal (l_mixed_2))
			assert ("zero_equal", l_mixed_1.zero.is_equal (l_mixed_2.zero))
			create l_mixed_1.make (False, 0, 3, 4)
			create l_mixed_2.make (False, 0, 3, 4)
			assert ("pos_is_equal", l_mixed_1.is_equal (l_mixed_2))
			create l_mixed_1.make (True, 5, 3, 4)
			create l_mixed_2.make (True, 5, 3, 4)
			assert ("neg_is_equal_2", l_mixed_1.is_equal (l_mixed_2))
			create l_mixed_2.make (True, 4, 14, 8)
			assert ("neg_mixed_denomators_is_equal", l_mixed_1.is_equal (l_mixed_2))

			-- Test for possible repeating binary
			create l_mixed_1.make (False, 0, 1, 3)
			create l_mixed_2.make (False, 0, 1, 3)
			assert ("neg_is_equal_third", l_mixed_1.is_equal (l_mixed_2))
			create l_mixed_1.make (False, 0, 1, 10)
			create l_mixed_2.make (False, 0, 1, 10)
			assert ("neg_is_equal_tenth", l_mixed_1.is_equal (l_mixed_2))

			create l_mixed_1.make (False, 3, 0, 3)
			create l_mixed_2.make (False, 3, 0, 1)
			assert ("mixed_denominators", l_mixed_1.is_equal (l_mixed_2))
		end

	proper_fraction_part_test
			-- Test proper fraction part.
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.make (False, 5, 3, 4)
			assert ("within_0000000001_pct_tolerance", is_within_tolerance(l_mixed.proper_fraction_part, 3/4, 0.000000000001))
		end

	is_within_tolerance (a_real_1, a_real_2, a_tolerance: REAL_64): BOOLEAN
			-- Is `a_real_1' within `a_tolerance' of `a_real_2'?
			--| `a_tolerance' is a degree or fractional variance allowable from `a_real_1'.
			--| (e.g. a tolerance of 0.01 a tolerance of +/- 1%, inclusive)
		note
			testing:  "run/checkin/regular"
		do
			Result := (a_real_2 <= (a_real_1 + (a_real_1 * a_tolerance))) and (a_real_2 >= (a_real_1 - (a_real_1 * a_tolerance)))
		end

	is_within_toleranace_test
			-- Is `is_within_tolerance' ok?
		note
			testing:  "run/checkin/regular"
		do
			assert ("equal_integers_within_tolerance", is_within_tolerance (12, 12, 0.01))
			assert ("equal_integers_not_within_tolerance", not is_within_tolerance (12, 14, 0.01))
		end

	abs_negative_test
			-- Test Absolute value and negative values of mixed numbers.
		note
			testing:  "run/checkin/regular"
		local
			l_mixed, l_mixed_neg, l_mixed_abs, l_mixed_abs_neg: MIXED_NUMBER
		do
			create l_mixed.make (False, 5, 3, 4)
			l_mixed_neg := - l_mixed
			assert ("whole_part_five", l_mixed_neg.whole_part = 5)
			assert ("is_negative", l_mixed_neg.is_negative)
			assert ("numerator_3", l_mixed_neg.numerator = 3)
			assert ("denominator_4", l_mixed_neg.denominator = 4)
			l_mixed_abs := l_mixed.abs
			assert ("abs_mixed", l_mixed_abs.whole_part = 5)
			assert ("not_negative_abs", not l_mixed_abs.is_negative)
			assert ("numerator_3_abs", l_mixed_abs.numerator = 3)
			assert ("denominator_4_abs", l_mixed_abs.denominator = 4)
			l_mixed_abs_neg := l_mixed_neg.abs
			assert ("abs_neg_mixed", l_mixed_abs_neg.whole_part = 5)
			assert ("not_negative_abs_neg", not l_mixed_abs.is_negative)
			assert ("numerator_3_abs_neg", l_mixed_abs_neg.numerator = 3)
			assert ("denominator_4_abs_neg", l_mixed_abs_neg.denominator = 4)
		end

	has_same_denominator_test
			-- Test `has_same_denominator'
		note
			testing:  "run/checkin/regular"
		local
			l_mixed_1, l_mixed_2: MIXED_NUMBER
		do
			create l_mixed_1.make (False, 0, 1, 3)
			create l_mixed_2.make (False, 0, 2, 3)
			assert ("matching_denominators", l_mixed_1.has_same_denominator (l_mixed_2))
			create l_mixed_1.make (False, 0, 1, 3)
			create l_mixed_2.make (False, 0, 2, 4)
			assert ("not_matching_denominators", not l_mixed_1.has_same_denominator (l_mixed_2))
		end

	is_whole_number_test
			-- Test `is_whole_number'
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.make (False, 0, 0, 1)
			assert ("zero_whole_number_1", l_mixed.is_whole_number)
			create l_mixed.make (False, 3, 0, 3)
			assert ("zero_whole_number_3", l_mixed.is_whole_number)
			assert ("three_expected", l_mixed.denominator = 3)
			create l_mixed.make (True, 5, 0, 3)
			assert ("zero_whole_number_neg_5", l_mixed.is_whole_number)
			assert ("three_expected", l_mixed.denominator = 3)
		end

	to_double_test
			-- Test `to_double'
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.default_create
			assert ("with_zero", l_mixed.to_double = (0).to_double)
			create l_mixed.make (False, 5, 0, 1)
			assert ("with_5", l_mixed.to_double = (5).to_double)
			create l_mixed.make (False, 5, 3, 4)
			assert ("with_5_3_4", l_mixed.to_double = 5.75) -- 5.75 is double.
		end

	plus_test
			-- Test `plus'
		note
			testing:  "run/checkin/regular"
		local
			l_mixed_1, l_mixed_2, l_mixed_answer: MIXED_NUMBER
			l_decimal: DECIMAL
			l_integer: INTEGER
			l_real: REAL
		do
			create l_mixed_1.make (False, 1, 2, 3)
			create l_mixed_2.make (False, 1, 1, 3)
			create l_mixed_answer.make (False, 3, 0, 1)
			assert ("is_equal_denominator_3", (l_mixed_1 + l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (False, 1, 2, 3)
			create l_mixed_2.make (False, 1, 1, 6)
			create l_mixed_answer.make (False, 2, 5, 6)
			assert ("is_equal_denominator_6", (l_mixed_1 + l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (False, 1, 5, 3)
			create l_mixed_2.make (False, 1, 1, 6)
			create l_mixed_answer.make (False, 3, 5, 6)
			assert ("is_equal_improper_fraction_non_matching_denominator", (l_mixed_1 + l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (True, 3, 2, 3)
			create l_mixed_2.make (False, 1, 1, 3)
			create l_mixed_answer.make (True, 2, 1, 3)
			assert ("is_equal_neg_2_1_3", (l_mixed_1 + l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (True, 3, 2, 3)
			create l_mixed_2.make (True, 1, 1, 3)
			create l_mixed_answer.make (True, 5, 0, 1)
			assert ("is_equal_neg_5_0_1", (l_mixed_1 + l_mixed_2) ~ (l_mixed_answer))

				-- DECIMAL
			create l_mixed_1.make_positive (3, 2, 3)
			create l_decimal.make_from_string ("1.3333")
			create l_mixed_answer.make_positive (4, 29999, 30000)
			assert_strings_equal ("mixed_plus_decimal", (l_mixed_1 + l_decimal).out, l_mixed_answer.out)

				-- REAL
			create l_mixed_1.make_positive (3, 2, 3)
			l_real := 1.3333
			create l_mixed_answer.make_positive (4, 29999, 30000)
			assert_strings_equal ("mixed_plus_real", (l_mixed_1 + l_real).out, l_mixed_answer.out)

				-- INTEGER
			create l_mixed_1.make_positive (3, 2, 3)
			l_integer := 2
			create l_mixed_answer.make_positive (5, 2, 3)
			assert_strings_equal ("mixed_plus_real", (l_mixed_1 + l_integer).out, l_mixed_answer.out)
			assert_strings_equal ("mixed_plus_real", (l_integer + l_mixed_1).out, l_mixed_answer.out) -- works either way!

		end

	minus_test
			-- Test `minus' feature
		note
			testing:  "run/checkin/regular"
		local
			l_mixed_1, l_mixed_2, l_mixed_answer: MIXED_NUMBER
		do
			create l_mixed_1.make (False, 1, 2, 3)
			create l_mixed_2.make (False, 1, 1, 3)
			create l_mixed_answer.make (False, 0, 1, 3)
			assert ("is_equal_denominator_3", (l_mixed_1 - l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (False, 1, 2, 3)
			create l_mixed_2.make (False, 1, 1, 6)
			create l_mixed_answer.make (False, 0, 1, 2)
			assert ("is_equal_denominator_6", (l_mixed_1 - l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (False, 1, 5, 3)
			create l_mixed_2.make (False, 1, 1, 6)
			create l_mixed_answer.make (False, 1, 1, 2)
			assert ("is_equal_improper_fraction_non_matching_denominator", (l_mixed_1 - l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (True, 3, 2, 3)
			create l_mixed_2.make (False, 1, 1, 3)
			create l_mixed_answer.make (True, 5, 0, 1)
			assert ("is_equal_neg_5_0_1", (l_mixed_1 - l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (True, 3, 2, 3)
			create l_mixed_2.make (True, 1, 1, 3)
			create l_mixed_answer.make (True, 2, 1, 3)
			assert ("is_equal_neg_2_1_3", (l_mixed_1 - l_mixed_2) ~ (l_mixed_answer))

		end

	zero_subtraction_test
			-- Test 0 - 0
		note
			testing:  "run/checkin/regular"
		local
			l_one, l_two, l_three: MIXED_NUMBER
		do
			create l_one
			create l_two
			create l_three
			assert ("zero_minus_zero_is_zero", l_one.minus (l_two).is_equal (l_three))
			create l_one.make (False, 0, 0, 12)
			create l_two.make (False, 0, 0, 12)
			create l_three.make (False, 0, 0, 12)
			assert ("zero_12ths_minus_zero_12ths_is_zero_12ths", l_one.minus (l_two).is_equal (l_three))
		end

	product_test
			-- Test `product' feature
		note
			testing:  "run/checkin/regular"
		local
			l_mixed_1, l_mixed_2, l_mixed_answer: MIXED_NUMBER
			l_integer: INTEGER
			l_real: REAL
			l_decimal: DECIMAL
		do
			create l_mixed_1.make (False, 1, 2, 3)
			create l_mixed_2.make (False, 1, 1, 3)
			create l_mixed_answer.make (False, 2, 2, 9)
			assert ("product_1_correct", (l_mixed_1 * l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (False, 1, 2, 3)
			create l_mixed_2.make (False, 1, 1, 6)
			create l_mixed_answer.make (False, 1, 17, 18)
			assert ("product_2_correct", (l_mixed_1 * l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (False, 1, 5, 3)
			create l_mixed_2.make (False, 1, 1, 6)
			create l_mixed_answer.make (False, 3, 1, 9)
			assert ("product_3_correct", (l_mixed_1 * l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (True, 3, 2, 3)
			create l_mixed_2.make (False, 1, 1, 3)
			create l_mixed_answer.make (True, 4, 8, 9)
			assert ("product_4_correct", (l_mixed_1 * l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (True, 3, 2, 3)
			create l_mixed_2.make (True, 1, 1, 3)
			create l_mixed_answer.make (False, 4, 8, 9)
			assert ("product_5_correct", (l_mixed_1 * l_mixed_2) ~ (l_mixed_answer))

				-- Prep ...
			create l_mixed_1.make_positive (5, 2, 3)

				-- decimal
			create l_decimal.make_from_string ("10.559")
			create l_mixed_answer.make_positive (59, 2503, 3000)
			assert_strings_equal ("mixed_times_decimal_2", (l_mixed_1 * l_decimal).out, l_mixed_answer.out)

				-- integer
			l_integer := 1234
			create l_mixed_answer.make_positive (6992, 2, 3)
			assert_strings_equal ("mixed_times_integer", (l_mixed_1 * l_integer).out, l_mixed_answer.out)

				-- real
			l_real := 1234.987
			create l_mixed_1.make_positive (1, 0, 1)
			create l_mixed_answer.make_positive (1234, 99, 100)
			assert_strings_equal ("mixed_times_integer", (l_mixed_1 * l_real).out, l_mixed_answer.out)
		end

	quotient_test
			-- Test `quotient' feature
		note
			testing:  "run/checkin/regular"
		local
			l_mixed_1, l_mixed_2, l_mixed_answer: MIXED_NUMBER
		do
			create l_mixed_1.make (False, 1, 2, 3)
			create l_mixed_2.make (False, 1, 1, 3)
			create l_mixed_answer.make (False, 1, 1, 4)
			assert ("quotient_1_correct", (l_mixed_1 / l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (False, 1, 2, 3)
			create l_mixed_2.make (False, 1, 1, 6)
			create l_mixed_answer.make (False, 1, 3, 7)
			assert ("quotient_2_correct", (l_mixed_1 / l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (False, 1, 5, 3)
			create l_mixed_2.make (False, 1, 1, 6)
			create l_mixed_answer.make (False, 2, 2, 7)
			assert ("quotient_3_correct", (l_mixed_1 / l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (True, 3, 2, 3)
			create l_mixed_2.make (False, 1, 1, 3)
			create l_mixed_answer.make (True, 2, 3, 4)
			assert ("quotient_4_correct", (l_mixed_1 / l_mixed_2) ~ (l_mixed_answer))

			create l_mixed_1.make (True, 3, 2, 3)
			create l_mixed_2.make (True, 1, 1, 3)
			create l_mixed_answer.make (False, 2, 3, 4)
			assert ("quotient_5_correct", (l_mixed_1 / l_mixed_2) ~ (l_mixed_answer))

		end

	lcm_test
			-- Test least common multiple.
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.default_create
			assert ("lcm_2_2_2", l_mixed.lcm (2, 2) = 2)
			assert ("lcm_2_4_4", l_mixed.lcm (2, 4) = 4)
			assert ("lcm_2_3_6", l_mixed.lcm (2, 3) = 6)
			assert ("lcm_12_18_36", l_mixed.lcm (12, 18) = 36)
		end

	gcd_test
			-- Test greatest common denominator.
		note
			testing:  "run/checkin/regular"
		local
			l_mixed: MIXED_NUMBER
		do
			create l_mixed.default_create
			assert ("gcd_2_3_1", l_mixed.gcd (2, 3) = 1)
			assert ("gcd_4_4_4", l_mixed.gcd (4, 4) = 4)
			assert ("gcd_8_12_4", l_mixed.gcd (8, 12) = 4)
			assert ("gcd_15_35_5", l_mixed.gcd (15, 35) = 5)
			assert ("gcd_15_45_5", not (l_mixed.gcd (15, 45) = 5))
		end

end


