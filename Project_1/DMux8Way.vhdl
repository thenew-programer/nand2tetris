// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/1/DMux4Way.hdl
/**
 * 4-way demultiplexor:
 * [a, b, c, d, e, f, g, h] = [in, 0, 0, 0, 0, 0, 0, 0] if sel = 000
 *							  [0, in, 0, 0, 0, 0, 0, 0] if sel = 001
 *							  [0, 0, in, 0, 0, 0, 0, 0] if sel = 010
 *							  [0, 0, 0, in, 0, 0, 0, 0] if sel = 011
 *							  [0, 0, 0, 0, in, 0, 0, 0] if sel = 100
 *							  [0, 0, 0, 0, 0, in, 0, 0] if sel = 101
 *							  [0, 0, 0, 0, 0, 0, in, 0] if sel = 110
 *							  [0, 0, 0, 0, 0, 0, 0, in] if sel = 111
 */
CHIP DMux8Way {
    IN in, sel[3];
    OUT a, b, c, d, e, f, g, h;

    PARTS:
	DMux(in=in, sel=sel[2], a=abcd, b=efgh);
	DMux4Way(in=abcd, sel=sel[0..1], a=a, b=b, c=c, d=d);
	DMux4Way(in=efgh, sel=sel[0..1], a=e, b=f, c=h, d=h);
}
