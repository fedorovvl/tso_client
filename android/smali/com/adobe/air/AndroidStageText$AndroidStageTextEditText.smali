.class public Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;
.super Landroid/widget/EditText;
.source "AndroidStageText.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidStageText;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "AndroidStageTextEditText"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;
    }
.end annotation


# instance fields
.field private mLastFocusDirection:I

.field private m_focusedChildView:Landroid/view/View;

.field private m_hasFocus:Z

.field private m_inRequestChildFocus:Z

.field final synthetic this$0:Lcom/adobe/air/AndroidStageText;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AndroidStageText;Landroid/content/Context;)V
    .locals 2
    .param p1, "this$0"    # Lcom/adobe/air/AndroidStageText;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 249
    iput-object p1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 250
    invoke-direct {p0, p2}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 244
    iput-boolean v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_inRequestChildFocus:Z

    .line 245
    iput-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_focusedChildView:Landroid/view/View;

    .line 246
    iput-boolean v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_hasFocus:Z

    .line 247
    iput v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->mLastFocusDirection:I

    .line 253
    invoke-virtual {p0, v1}, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 254
    invoke-virtual {p0, v0}, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->setCompoundDrawablePadding(I)V

    .line 255
    invoke-virtual {p0, v0, v0, v0, v0}, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->setPadding(IIII)V

    .line 258
    return-void
.end method

.method public constructor <init>(Lcom/adobe/air/AndroidStageText;Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2
    .param p1, "this$0"    # Lcom/adobe/air/AndroidStageText;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    const/4 v1, 0x0

    .line 260
    iput-object p1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 261
    invoke-direct {p0, p2, p3}, Landroid/widget/EditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 244
    iput-boolean v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_inRequestChildFocus:Z

    .line 245
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_focusedChildView:Landroid/view/View;

    .line 246
    iput-boolean v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_hasFocus:Z

    .line 247
    iput v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->mLastFocusDirection:I

    .line 263
    return-void
.end method

.method public constructor <init>(Lcom/adobe/air/AndroidStageText;Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2
    .param p1, "this$0"    # Lcom/adobe/air/AndroidStageText;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "attrs"    # Landroid/util/AttributeSet;
    .param p4, "defStyle"    # I

    .prologue
    const/4 v1, 0x0

    .line 265
    iput-object p1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 266
    invoke-direct {p0, p2, p3, p4}, Landroid/widget/EditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 244
    iput-boolean v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_inRequestChildFocus:Z

    .line 245
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_focusedChildView:Landroid/view/View;

    .line 246
    iput-boolean v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_hasFocus:Z

    .line 247
    iput v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->mLastFocusDirection:I

    .line 268
    return-void
.end method

.method private dispatchFocusEvent(ZI)V
    .locals 6
    .param p1, "focused"    # Z
    .param p2, "direction"    # I

    .prologue
    .line 362
    iget-boolean v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_hasFocus:Z

    if-ne v1, p1, :cond_1

    .line 387
    :cond_0
    :goto_0
    return-void

    .line 365
    :cond_1
    iput-boolean p1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_hasFocus:Z

    .line 367
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 369
    .local v0, "stageText":Lcom/adobe/air/AndroidStageText;
    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-eqz v1, :cond_0

    .line 376
    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$600(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AIRWindowSurfaceView;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 377
    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$600(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AIRWindowSurfaceView;

    move-result-object v1

    iget-boolean v2, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_hasFocus:Z

    invoke-virtual {v1, v0, v2}, Lcom/adobe/air/AIRWindowSurfaceView;->updateFocusedStageText(Lcom/adobe/air/AndroidStageText;Z)V

    .line 382
    :cond_2
    if-eqz p1, :cond_0

    .line 383
    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v2

    invoke-static {v0, v2, v3, p2}, Lcom/adobe/air/AndroidStageText;->access$700(Lcom/adobe/air/AndroidStageText;JI)V

    goto :goto_0
.end method


# virtual methods
.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 294
    iget-boolean v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->m_hasFocus:Z

    if-nez v0, :cond_0

    .line 297
    invoke-virtual {p0}, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->requestFocus()Z

    .line 300
    :cond_0
    invoke-super {p0, p1}, Landroid/widget/EditText;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0
.end method

.method public onCreateContextMenu(Landroid/view/ContextMenu;)V
    .locals 2
    .param p1, "menu"    # Landroid/view/ContextMenu;

    .prologue
    .line 465
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/adobe/air/AndroidStageText;->access$902(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 466
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/adobe/air/AndroidStageText;->access$1102(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 468
    invoke-super {p0, p1}, Landroid/widget/EditText;->onCreateContextMenu(Landroid/view/ContextMenu;)V

    .line 470
    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 7
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .prologue
    .line 273
    iget-object v3, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v3}, Lcom/adobe/air/AndroidStageText;->access$300(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 275
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 276
    iget-object v3, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v3}, Lcom/adobe/air/AndroidStageText;->access$400(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v3

    iget v3, v3, Landroid/graphics/Rect;->left:I

    neg-int v0, v3

    .line 277
    .local v0, "dx":I
    iget-object v3, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v3}, Lcom/adobe/air/AndroidStageText;->access$400(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v3

    iget v3, v3, Landroid/graphics/Rect;->top:I

    neg-int v1, v3

    .line 278
    .local v1, "dy":I
    new-instance v2, Landroid/graphics/Rect;

    iget-object v3, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v3}, Lcom/adobe/air/AndroidStageText;->access$300(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v3

    iget v3, v3, Landroid/graphics/Rect;->left:I

    add-int/2addr v3, v0

    iget-object v4, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v4}, Lcom/adobe/air/AndroidStageText;->access$300(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v4

    iget v4, v4, Landroid/graphics/Rect;->top:I

    add-int/2addr v4, v1

    iget-object v5, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v5}, Lcom/adobe/air/AndroidStageText;->access$300(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v5

    iget v5, v5, Landroid/graphics/Rect;->right:I

    add-int/2addr v5, v0

    iget-object v6, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v6}, Lcom/adobe/air/AndroidStageText;->access$300(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v6

    iget v6, v6, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v6, v1

    invoke-direct {v2, v3, v4, v5, v6}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 279
    .local v2, "r":Landroid/graphics/Rect;
    invoke-virtual {p1, v2}, Landroid/graphics/Canvas;->clipRect(Landroid/graphics/Rect;)Z

    .line 280
    invoke-super {p0, p1}, Landroid/widget/EditText;->onDraw(Landroid/graphics/Canvas;)V

    .line 281
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 287
    .end local v0    # "dx":I
    .end local v1    # "dy":I
    .end local v2    # "r":Landroid/graphics/Rect;
    :goto_0
    return-void

    .line 285
    :cond_0
    invoke-super {p0, p1}, Landroid/widget/EditText;->onDraw(Landroid/graphics/Canvas;)V

    goto :goto_0
.end method

.method protected onFocusChanged(ZILandroid/graphics/Rect;)V
    .locals 1
    .param p1, "focused"    # Z
    .param p2, "direction"    # I
    .param p3, "previouslyFocusedRect"    # Landroid/graphics/Rect;

    .prologue
    .line 395
    invoke-super {p0, p1, p2, p3}, Landroid/widget/EditText;->onFocusChanged(ZILandroid/graphics/Rect;)V

    .line 397
    if-nez p2, :cond_0

    .line 398
    iget p2, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->mLastFocusDirection:I

    .line 400
    :cond_0
    const/4 v0, 0x0

    iput v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->mLastFocusDirection:I

    .line 402
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->dispatchFocusEvent(ZI)V

    .line 403
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 5
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 503
    const/4 v0, 0x0

    .line 504
    .local v0, "result":Z
    sparse-switch p1, :sswitch_data_0

    .line 519
    :cond_0
    :goto_0
    if-nez v0, :cond_1

    .line 520
    invoke-super {p0, p1, p2}, Landroid/widget/EditText;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    .line 522
    :cond_1
    return v0

    .line 510
    :sswitch_0
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$1400(Lcom/adobe/air/AndroidStageText;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 511
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    iget-object v2, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v2}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v2

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getAction()I

    move-result v4

    invoke-static {v1, v2, v3, v4, p1}, Lcom/adobe/air/AndroidStageText;->access$1500(Lcom/adobe/air/AndroidStageText;JII)Z

    move-result v0

    goto :goto_0

    .line 504
    :sswitch_data_0
    .sparse-switch
        0x4 -> :sswitch_0
        0x42 -> :sswitch_0
        0x52 -> :sswitch_0
    .end sparse-switch
.end method

.method public onKeyPreIme(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 556
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$600(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AIRWindowSurfaceView;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getAction()I

    move-result v0

    if-nez v0, :cond_0

    .line 558
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$600(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AIRWindowSurfaceView;

    move-result-object v0

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->DispatchSoftKeyboardEventOnBackKey()V

    .line 560
    :cond_0
    invoke-super {p0, p1, p2}, Landroid/widget/EditText;->onKeyPreIme(ILandroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 5
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    .line 529
    const/4 v0, 0x0

    .line 531
    .local v0, "result":Z
    sparse-switch p1, :sswitch_data_0

    .line 546
    :cond_0
    :goto_0
    invoke-super {p0, p1, p2}, Landroid/widget/EditText;->onKeyUp(ILandroid/view/KeyEvent;)Z

    move-result v0

    .line 549
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/adobe/air/AndroidStageText;->access$1402(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 550
    return v0

    .line 538
    :sswitch_0
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$1400(Lcom/adobe/air/AndroidStageText;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 539
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    iget-object v2, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v2}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v2

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getAction()I

    move-result v4

    invoke-static {v1, v2, v3, v4, p1}, Lcom/adobe/air/AndroidStageText;->access$1500(Lcom/adobe/air/AndroidStageText;JII)Z

    goto :goto_0

    .line 531
    nop

    :sswitch_data_0
    .sparse-switch
        0x4 -> :sswitch_0
        0x42 -> :sswitch_0
        0x52 -> :sswitch_0
    .end sparse-switch
.end method

.method protected onLayout(ZIIII)V
    .locals 9
    .param p1, "changed"    # Z
    .param p2, "left"    # I
    .param p3, "top"    # I
    .param p4, "right"    # I
    .param p5, "bottom"    # I

    .prologue
    .line 344
    iget-object v7, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 347
    .local v7, "stageText":Lcom/adobe/air/AndroidStageText;
    invoke-super/range {p0 .. p5}, Landroid/widget/EditText;->onLayout(ZIIII)V

    .line 349
    invoke-static {v7}, Lcom/adobe/air/AndroidStageText;->access$000(Lcom/adobe/air/AndroidStageText;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 351
    const/4 v0, 0x0

    invoke-static {v7, v0}, Lcom/adobe/air/AndroidStageText;->access$002(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 352
    invoke-static {v7}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v0

    invoke-static {v7, v0, v1}, Lcom/adobe/air/AndroidStageText;->access$200(Lcom/adobe/air/AndroidStageText;J)V

    .line 355
    :cond_0
    const/16 v6, 0x4b

    .line 356
    .local v6, "kUpdateInterval":I
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$500(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

    move-result-object v8

    new-instance v0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;

    const/16 v2, 0xa

    const/16 v3, 0x4b

    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$500(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

    move-result-object v4

    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$600(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AIRWindowSurfaceView;

    move-result-object v5

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;-><init>(Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;IILcom/adobe/air/AndroidStageText$AndroidStageTextImpl;Lcom/adobe/air/AIRWindowSurfaceView;)V

    const-wide/16 v2, 0x4b

    invoke-virtual {v8, v0, v2, v3}, Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 357
    return-void
.end method

.method public onSelectionChanged(II)V
    .locals 4
    .param p1, "selStart"    # I
    .param p2, "selEnd"    # I

    .prologue
    const/4 v2, 0x1

    .line 488
    invoke-super {p0, p1, p2}, Landroid/widget/EditText;->onSelectionChanged(II)V

    .line 489
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0, v2}, Lcom/adobe/air/AndroidStageText;->access$1102(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 491
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$600(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AIRWindowSurfaceView;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$1200(Lcom/adobe/air/AndroidStageText;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 493
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$600(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AIRWindowSurfaceView;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$1300(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Lcom/adobe/air/AIRWindowSurfaceView;->showSoftKeyboard(ZLandroid/view/View;)V

    .line 494
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v2

    invoke-static {v0, v2, v3}, Lcom/adobe/air/AndroidStageText;->access$1000(Lcom/adobe/air/AndroidStageText;J)V

    .line 496
    :cond_0
    return-void
.end method

.method protected onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 6
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "start"    # I
    .param p3, "before"    # I
    .param p4, "after"    # I

    .prologue
    .line 407
    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/EditText;->onTextChanged(Ljava/lang/CharSequence;III)V

    .line 409
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 410
    .local v0, "stageText":Lcom/adobe/air/AndroidStageText;
    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-nez v1, :cond_0

    .line 414
    :goto_0
    return-void

    .line 413
    :cond_0
    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v2

    invoke-static {v0, v2, v3}, Lcom/adobe/air/AndroidStageText;->access$800(Lcom/adobe/air/AndroidStageText;J)V

    goto :goto_0
.end method

.method public onTextContextMenuItem(I)Z
    .locals 4
    .param p1, "id"    # I

    .prologue
    const/4 v3, 0x0

    .line 476
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    const/4 v2, 0x1

    invoke-static {v1, v2}, Lcom/adobe/air/AndroidStageText;->access$1202(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 477
    invoke-super {p0, p1}, Landroid/widget/EditText;->onTextContextMenuItem(I)Z

    move-result v0

    .line 479
    .local v0, "result":Z
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1, v3}, Lcom/adobe/air/AndroidStageText;->access$1202(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 480
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1, v3}, Lcom/adobe/air/AndroidStageText;->access$902(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 481
    return v0
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v7, 0x1

    .line 422
    const/4 v1, 0x1

    .line 423
    .local v1, "allUp":Z
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v5

    if-ge v2, v5, :cond_1

    .line 425
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    .line 426
    .local v0, "action":I
    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v3

    .line 430
    .local v3, "pointerid":I
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v5

    if-eq v5, v7, :cond_0

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v5

    const v6, 0xff00

    and-int/2addr v6, v0

    shr-int/lit8 v6, v6, 0x8

    invoke-virtual {p1, v6}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v6

    if-ne v5, v6, :cond_5

    .line 432
    :cond_0
    and-int/lit16 v0, v0, 0xff

    .line 433
    const/4 v5, 0x6

    if-eq v0, v5, :cond_5

    if-eq v0, v7, :cond_5

    .line 435
    const/4 v1, 0x0

    .line 441
    .end local v0    # "action":I
    .end local v3    # "pointerid":I
    :cond_1
    if-eqz v1, :cond_4

    .line 445
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0xb

    if-ge v5, v6, :cond_2

    iget-object v5, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v5}, Lcom/adobe/air/AndroidStageText;->access$900(Lcom/adobe/air/AndroidStageText;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 448
    :cond_2
    iget-object v5, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    iget-object v6, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v6}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v6

    invoke-static {v5, v6, v7}, Lcom/adobe/air/AndroidStageText;->access$1000(Lcom/adobe/air/AndroidStageText;J)V

    .line 452
    :cond_3
    iget-object v5, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    const/4 v6, 0x0

    invoke-static {v5, v6}, Lcom/adobe/air/AndroidStageText;->access$902(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 456
    :cond_4
    invoke-super {p0, p1}, Landroid/widget/EditText;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v4

    .line 458
    .local v4, "result":Z
    return v4

    .line 423
    .end local v4    # "result":Z
    .restart local v0    # "action":I
    .restart local v3    # "pointerid":I
    :cond_5
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method public startActionMode(Landroid/view/ActionMode$Callback;)Landroid/view/ActionMode;
    .locals 4
    .param p1, "callback"    # Landroid/view/ActionMode$Callback;

    .prologue
    .line 568
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$600(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AIRWindowSurfaceView;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$1100(Lcom/adobe/air/AndroidStageText;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 570
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v0}, Lcom/adobe/air/AndroidStageText;->access$600(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AIRWindowSurfaceView;

    move-result-object v0

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v2}, Lcom/adobe/air/AndroidStageText;->access$1300(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/adobe/air/AIRWindowSurfaceView;->showSoftKeyboard(ZLandroid/view/View;)V

    .line 571
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$100(Lcom/adobe/air/AndroidStageText;)J

    move-result-wide v2

    invoke-static {v0, v2, v3}, Lcom/adobe/air/AndroidStageText;->access$1000(Lcom/adobe/air/AndroidStageText;J)V

    .line 572
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;->this$0:Lcom/adobe/air/AndroidStageText;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/adobe/air/AndroidStageText;->access$1102(Lcom/adobe/air/AndroidStageText;Z)Z

    .line 574
    :cond_0
    invoke-super {p0, p1}, Landroid/widget/EditText;->startActionMode(Landroid/view/ActionMode$Callback;)Landroid/view/ActionMode;

    move-result-object v0

    return-object v0
.end method
