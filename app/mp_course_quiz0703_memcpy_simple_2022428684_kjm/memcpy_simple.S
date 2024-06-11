/*
 * Copyright (c) 2022 Sung Ho Park and CSOS
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <ubinos_config.h>

    .syntax unified
    .arch   armv7-m

    .text
    .thumb

    .thumb_func
    .align  1
    .globl  memcpy_simple
    .type   memcpy_simple, %function
    /* memcpy_simple.h 에서 정의된 함수, memcpy_simple 를 구현하라. */
    // 각 매개변수 전달을 위해 사용되는 레지스터
    //    void * destination : r0
    //    void * source      : r1
    //    size_t size        : r2
    // 사용 명령: movs, cmp, beq, strb, adds, b, bx, ldrb, push, pop
memcpy_simple:
    push    {r4, r5}        // r4, r5 레지스터를 스택에 저장
    movs    r5, r0          // r5에 r0(destination) 저장

    cmp     r2, #0          // size가 0인지 비교
    beq     end             // size가 0이면 복사 종료

loop:
    ldrb    r3, [r1]        // source 주소 (r1)에서 바이트를 로드
    adds    r1, r1, #1      // r1을 1 증가

    strb    r3, [r0]        // destination 주소 (r0)에 바이트를 저장
    adds    r0, r0, #1      // r0을 1 증가

    adds    r4, r4, #1      // r4를 1 증가 (카운터)
    cmp     r4, r2          // r4와 r2(size)를 비교
    beq     end             // r4가 r2와 같으면 루프 종료
    b       loop            // 그렇지 않으면 loop로 분기

end:
    movs    r0, r5          // r0를 r5(destination 시작 주소)로 설정
    pop     {r4, r5}        // r4, r5 레지스터를 스택에서 복원
    bx      lr              // 함수에서 복귀

