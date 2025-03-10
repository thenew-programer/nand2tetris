/** 
 * Multiplexor:
 * if (sel = 0) out = a, else out = b
 */
CHIP Mux {
	IN a, b, sel;
	OUT out;

	PARTS:
    Not(in=sel, out=nsel);
	And(a=a, b=nsel, out=aAndsel);
	And(a=b, b=sel, out=bAndsel);
    Or(a=aAndsel, b=bAndsel, out=out);
}
