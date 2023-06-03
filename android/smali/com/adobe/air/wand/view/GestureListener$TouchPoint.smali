.class Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
.super Ljava/lang/Object;
.source "GestureListener.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/view/GestureListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "TouchPoint"
.end annotation


# instance fields
.field private pid:I

.field final synthetic this$0:Lcom/adobe/air/wand/view/GestureListener;

.field private x:F

.field private y:F


# direct methods
.method constructor <init>(Lcom/adobe/air/wand/view/GestureListener;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 103
    iput-object p1, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->this$0:Lcom/adobe/air/wand/view/GestureListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 104
    iput v0, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->x:F

    .line 105
    iput v0, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->y:F

    .line 106
    const/4 v0, 0x0

    iput v0, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->pid:I

    .line 107
    return-void
.end method

.method constructor <init>(Lcom/adobe/air/wand/view/GestureListener;FFI)V
    .locals 0
    .param p2, "xVal"    # F
    .param p3, "yVal"    # F
    .param p4, "pointerID"    # I

    .prologue
    .line 109
    iput-object p1, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->this$0:Lcom/adobe/air/wand/view/GestureListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 110
    iput p2, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->x:F

    .line 111
    iput p3, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->y:F

    .line 112
    iput p4, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->pid:I

    .line 113
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;FFI)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;
    .param p1, "x1"    # F
    .param p2, "x2"    # F
    .param p3, "x3"    # I

    .prologue
    .line 100
    invoke-direct {p0, p1, p2, p3}, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->assign(FFI)V

    return-void
.end method

.method static synthetic access$100(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .prologue
    .line 100
    iget v0, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->pid:I

    return v0
.end method

.method static synthetic access$200(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .prologue
    .line 100
    iget v0, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->x:F

    return v0
.end method

.method static synthetic access$300(Lcom/adobe/air/wand/view/GestureListener$TouchPoint;)F
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/wand/view/GestureListener$TouchPoint;

    .prologue
    .line 100
    iget v0, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->y:F

    return v0
.end method

.method private assign(FFI)V
    .locals 0
    .param p1, "xVal"    # F
    .param p2, "yVal"    # F
    .param p3, "pointerID"    # I

    .prologue
    .line 125
    iput p1, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->x:F

    .line 126
    iput p2, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->y:F

    .line 127
    iput p3, p0, Lcom/adobe/air/wand/view/GestureListener$TouchPoint;->pid:I

    .line 128
    return-void
.end method
