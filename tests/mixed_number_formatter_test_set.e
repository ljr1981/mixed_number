note
	description: "Summary description for {MIXED_NUMBER_FORMATTER_TEST_SET}."
	author: ""
	date: "$Date: 2015-06-01 13:07:14 -0400 (Mon, 01 Jun 2015) $"
	revision: "$Revision: 11416 $"

class
	MIXED_NUMBER_FORMATTER_TEST_SET

inherit
	EQA_TEST_SET
	
	MIXED_NUMBER_FORMATTER

feature -- Test routines

	test_string_format_for_mixed_number_without_zero_fraction
			-- Tests {MIXED_NUMBER_FORMATTER}.string_format_for_mixed_number_without_zero_fraction
		do
			-- Positive numbers.
			assert ("0", string_format_for_mixed_number_without_zero_fraction (create {MIXED_NUMBER}.make (False, 0, 0, 1)).out.same_string_general ("0"))
			assert ("5", string_format_for_mixed_number_without_zero_fraction (create {MIXED_NUMBER}.make (False, 5, 0, 1)).out.same_string_general ("5"))
			assert ("0 1/2", string_format_for_mixed_number_without_zero_fraction (create {MIXED_NUMBER}.make (False, 0, 1, 2)).out.same_string_general ("0 1/2"))
			assert ("1 3/4", string_format_for_mixed_number_without_zero_fraction (create {MIXED_NUMBER}.make (False, 1, 3, 4)).out.same_string_general ("1 3/4"))
			assert ("10 5/8", string_format_for_mixed_number_without_zero_fraction (create {MIXED_NUMBER}.make (False, 10, 5, 8)).out.same_string_general ("10 5/8"))
			-- Negative numbers.
			assert ("-5", string_format_for_mixed_number_without_zero_fraction (create {MIXED_NUMBER}.make (True, 5, 0, 1)).out.same_string_general ("-5"))
			assert ("-0 1/2", string_format_for_mixed_number_without_zero_fraction (create {MIXED_NUMBER}.make (True, 0, 1, 2)).out.same_string_general ("-0 1/2"))
			assert ("-1 3/4", string_format_for_mixed_number_without_zero_fraction (create {MIXED_NUMBER}.make (True, 1, 3, 4)).out.same_string_general ("-1 3/4"))
			assert ("-10 5/8", string_format_for_mixed_number_without_zero_fraction (create {MIXED_NUMBER}.make (True, 10, 5, 8)).out.same_string_general ("-10 5/8"))
		end

end
