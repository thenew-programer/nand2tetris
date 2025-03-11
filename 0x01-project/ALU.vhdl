/**
 * ALU (Arithmetic Logic Unit):
 * Computes out = one of the following functions:
 *                0, 1, -1,
 *                x, y, !x, !y, -x, -y,
 *                x + 1, y + 1, x - 1, y - 1,
 *                x + y, x - y, y - x,
 *                x & y, x | y
 * on the 16-bit inputs x, y,
 * according to the input bits zx, nx, zy, ny, f, no.
 * In addition, computes the two output bits:
 * if (out == 0) zr = 1, else zr = 0
 * if (out < 0)  ng = 1, else ng = 0
 */
/* Implementation: Manipulates the x and y inputs
** and operates on the resulting values, as follows:
** if (zx == 1) sets x = 0        // 16-bit constant
** if (nx == 1) sets x = !x       // bitwise not
** if (zy == 1) sets y = 0        // 16-bit constant
** if (ny == 1) sets y = !y       // bitwise not
** if (f == 1)  sets out = x + y  // integer 2's complement addition
** if (f == 0)  sets out = x & y  // bitwise and
** if (no == 1) sets out = !out   // bitwise not
*/

CHIP ALU {
    IN  
        x[16], y[16],  // 16-bit inputs        
        zx, // zero the x input?
        nx, // negate the x input?
        zy, // zero the y input?
        ny, // negate the y input?
        f,  // compute (out = x + y) or (out = x & y)?
        no; // negate the out output?
    OUT 
        out[16], // 16-bit output
        zr,      // if (out == 0) equals 1, else 0
        ng;      // if (out < 0)  equals 1, else 0

    PARTS:
	/* zx, nx */
	Mux16(a=x , b=false , sel=zx , out=zerox);
	Not16(in=zerox, out=notx);
	Mux16(a=zerox, b=notx, sel=nx, out=inx);

	/* zy, ny */
	Mux16(a=y , b=false , sel=zy , out=zeroy);
	Not16(in=zeroy, out=noty);
	Mux16(a=zeroy, b=noty, sel=ny, out=iny);

	/* f */
	Add16(a=inx, b=iny, out=xPlusy);
	And16(a=inx, b=iny, out=xAndy);
	Mux16(a=xAndy, b=xPlusy, sel=f, out=fout);

	/* no, ng */
	Not16(in=fout, out=nfout);
	Mux(a=fout, b=nfout, sel=no, out=out, out[15]=ng, out[0..7]=f8out, out[8..15]=s8out);

	/* zr */
	Or8Way(a=f8out, out=zr1);
	Or8Way(a=s8out, out=zr2);
	Or(a=zr1, b=zr2, out=nzr);
	Not(in=nzr, out=zr);
}
