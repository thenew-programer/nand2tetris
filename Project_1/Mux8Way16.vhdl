/**
 * 8-way 16-bit multiplexor:
 * out = a if sel = 000
 *       b if sel = 001
 *       c if sel = 010
 *       d if sel = 011
 *       e if sel = 100
 *       f if sel = 101
 *       g if sel = 110
 *       h if sel = 111
CHIP Mux8Way16 {
    IN a[16], b[16], c[16], d[16],
       e[16], f[16], g[16], h[16],
       sel[3];
    OUT out[16];

    PARTS:
	Mux4Way16(a=a, b=b, c=c, d=d, sel=[sel[0], sel[1]], out=i);
	Mux4Way16(a=e, b=f, c=g, d=h, sel=[sel[0], sel[1]], out=j);
	Mux16(a=i, b=j, sel=sel[2], out=out);
}
*/
CHIP Mux8Way16 {
    IN a[16], b[16], c[16], d[16],
       e[16], f[16], g[16], h[16],
       sel[3];
    OUT out[16];

    PARTS:
	Mux16(a=a, b=b, sel=sel[0], out=i);
	Mux16(a=c, b=d, sel=sel[0], out=j);
	Mux16(a=e, b=f, sel=sel[0], out=k);
	Mux16(a=g, b=h, sel=sel[0], out=l);

	Mux16(a=i, b=j, sel=sel[1], out=m);
	Mux16(a=k, b=l, sel=sel[1], out=n);

	Mux16(a=m, b=n, sel=sel[2], out=out);
}
