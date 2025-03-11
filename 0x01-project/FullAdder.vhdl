/**
 * Computes the sum of three bits.
 */
CHIP FullAdder {
    IN a, b, c;  // 1-bit inputs
    OUT sum,     // Right bit of a + b + c
        carry;   // Left bit of a + b + c

    PARTS:
	HalfAdder(a=a, b=b, sum=s1, carry=c1);
	HalfAdder(a=s1, b=c, sum=sum, carry=c2);
	Or(a=c1, b=c2, out=carry);
}
