.class public Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;
.super Landroid/graphics/drawable/ShapeDrawable;
.source "AndroidStageText.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidStageText;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "BackgroundBorderDrawable"
.end annotation


# instance fields
.field public mBkgColor:I

.field public mBkgPaint:Landroid/graphics/Paint;

.field public mBorderColor:I

.field public mHaveBkg:Z

.field public mHaveBorder:Z

.field final synthetic this$0:Lcom/adobe/air/AndroidStageText;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AndroidStageText;)V
    .locals 1
    .param p1, "this$0"    # Lcom/adobe/air/AndroidStageText;

    .prologue
    const/4 v0, 0x0

    .line 127
    iput-object p1, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 128
    invoke-direct {p0}, Landroid/graphics/drawable/ShapeDrawable;-><init>()V

    .line 169
    iput-boolean v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mHaveBorder:Z

    .line 170
    iput-boolean v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mHaveBkg:Z

    .line 171
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBkgColor:I

    .line 172
    const/high16 v0, -0x1000000

    iput v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBorderColor:I

    .line 129
    invoke-direct {p0}, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->init()V

    .line 130
    return-void
.end method

.method public constructor <init>(Lcom/adobe/air/AndroidStageText;Landroid/graphics/drawable/shapes/Shape;)V
    .locals 1
    .param p1, "this$0"    # Lcom/adobe/air/AndroidStageText;
    .param p2, "s"    # Landroid/graphics/drawable/shapes/Shape;

    .prologue
    const/4 v0, 0x0

    .line 133
    iput-object p1, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 134
    invoke-direct {p0, p2}, Landroid/graphics/drawable/ShapeDrawable;-><init>(Landroid/graphics/drawable/shapes/Shape;)V

    .line 169
    iput-boolean v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mHaveBorder:Z

    .line 170
    iput-boolean v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mHaveBkg:Z

    .line 171
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBkgColor:I

    .line 172
    const/high16 v0, -0x1000000

    iput v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBorderColor:I

    .line 135
    invoke-direct {p0}, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->init()V

    .line 136
    return-void
.end method

.method private init()V
    .locals 2

    .prologue
    .line 149
    new-instance v0, Landroid/graphics/Paint;

    invoke-virtual {p0}, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->getPaint()Landroid/graphics/Paint;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(Landroid/graphics/Paint;)V

    iput-object v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBkgPaint:Landroid/graphics/Paint;

    .line 150
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBkgPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 151
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBkgPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBkgColor:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 152
    invoke-virtual {p0}, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->getPaint()Landroid/graphics/Paint;

    move-result-object v0

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 153
    invoke-virtual {p0}, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->getPaint()Landroid/graphics/Paint;

    move-result-object v0

    const/high16 v1, 0x40400000    # 3.0f

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 154
    invoke-virtual {p0}, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->getPaint()Landroid/graphics/Paint;

    move-result-object v0

    iget v1, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBorderColor:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 155
    return-void
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/drawable/shapes/Shape;Landroid/graphics/Canvas;Landroid/graphics/Paint;)V
    .locals 2
    .param p1, "shape"    # Landroid/graphics/drawable/shapes/Shape;
    .param p2, "canvas"    # Landroid/graphics/Canvas;
    .param p3, "paint"    # Landroid/graphics/Paint;

    .prologue
    .line 141
    iget-boolean v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mHaveBkg:Z

    if-eqz v0, :cond_0

    .line 142
    invoke-virtual {p0}, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBkgPaint:Landroid/graphics/Paint;

    invoke-virtual {p2, v0, v1}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    .line 143
    :cond_0
    iget-boolean v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mHaveBorder:Z

    if-eqz v0, :cond_1

    .line 144
    invoke-super {p0, p1, p2, p3}, Landroid/graphics/drawable/ShapeDrawable;->onDraw(Landroid/graphics/drawable/shapes/Shape;Landroid/graphics/Canvas;Landroid/graphics/Paint;)V

    .line 145
    :cond_1
    return-void
.end method

.method public setBkgColor(I)V
    .locals 1
    .param p1, "c"    # I

    .prologue
    .line 159
    iput p1, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBkgColor:I

    .line 160
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBkgPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 161
    return-void
.end method

.method public setBorderColor(I)V
    .locals 1
    .param p1, "c"    # I

    .prologue
    .line 165
    iput p1, p0, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->mBorderColor:I

    .line 166
    invoke-virtual {p0}, Lcom/adobe/air/AndroidStageText$BackgroundBorderDrawable;->getPaint()Landroid/graphics/Paint;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 167
    return-void
.end method
