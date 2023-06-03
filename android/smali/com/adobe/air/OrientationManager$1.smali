.class Lcom/adobe/air/OrientationManager$1;
.super Landroid/view/OrientationEventListener;
.source "OrientationManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/OrientationManager;->onActivityCreated(Landroid/app/Activity;Lcom/adobe/air/AIRWindowSurfaceView;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/OrientationManager;


# direct methods
.method constructor <init>(Lcom/adobe/air/OrientationManager;Landroid/content/Context;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/OrientationManager;
    .param p2, "x0"    # Landroid/content/Context;
    .param p3, "x1"    # I

    .prologue
    .line 225
    iput-object p1, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-direct {p0, p2, p3}, Landroid/view/OrientationEventListener;-><init>(Landroid/content/Context;I)V

    return-void
.end method


# virtual methods
.method public onOrientationChanged(I)V
    .locals 10
    .param p1, "orientation"    # I

    .prologue
    const/16 v9, 0xe1

    const/16 v8, 0x87

    const/16 v5, 0x2d

    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 228
    sget-object v4, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v4}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v3

    .line 242
    .local v3, "preferredDisplayOrientation":I
    const/4 v4, -0x1

    if-ne p1, v4, :cond_3

    .line 244
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v5

    invoke-static {v4, v5}, Lcom/adobe/air/OrientationManager;->access$002(Lcom/adobe/air/OrientationManager;I)I

    .line 245
    sget-object v4, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v4}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v3

    .line 268
    :cond_0
    :goto_0
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v4

    invoke-virtual {v4}, Lcom/adobe/air/AndroidActivityWrapper;->isApplicationLaunched()Z

    move-result v4

    if-eqz v4, :cond_a

    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    .line 269
    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$100(Lcom/adobe/air/OrientationManager;)Z

    move-result v4

    if-ne v4, v6, :cond_a

    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$200(Lcom/adobe/air/OrientationManager;)I

    move-result v4

    iget-object v5, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v5}, Lcom/adobe/air/OrientationManager;->access$000(Lcom/adobe/air/OrientationManager;)I

    move-result v5

    if-eq v4, v5, :cond_a

    sget-object v4, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    .line 270
    invoke-virtual {v4}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v4

    if-eq v3, v4, :cond_a

    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$300(Lcom/adobe/air/OrientationManager;)I

    move-result v4

    if-eq v4, v3, :cond_a

    .line 272
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$400(Lcom/adobe/air/OrientationManager;)Landroid/app/Activity;

    move-result-object v4

    invoke-virtual {v4}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "accelerometer_rotation"

    invoke-static {v4, v5, v7}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 274
    .local v0, "accelRotation":I
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$400(Lcom/adobe/air/OrientationManager;)Landroid/app/Activity;

    move-result-object v4

    if-eqz v4, :cond_2

    if-eqz v0, :cond_2

    .line 276
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$500(Lcom/adobe/air/OrientationManager;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 279
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    iget-object v5, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v5}, Lcom/adobe/air/OrientationManager;->access$300(Lcom/adobe/air/OrientationManager;)I

    move-result v5

    invoke-virtual {v4, v5, v3}, Lcom/adobe/air/OrientationManager;->nativeOrientationChanging(II)Z

    move-result v1

    .line 280
    .local v1, "eventCancelled":Z
    if-eqz v1, :cond_9

    .line 282
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    iget-object v5, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v5}, Lcom/adobe/air/OrientationManager;->access$300(Lcom/adobe/air/OrientationManager;)I

    move-result v5

    invoke-virtual {v4, v5}, Lcom/adobe/air/OrientationManager;->setNearestOrientation(I)V

    .line 294
    :cond_1
    :goto_1
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    iget-object v5, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v5}, Lcom/adobe/air/OrientationManager;->access$300(Lcom/adobe/air/OrientationManager;)I

    move-result v5

    invoke-static {v4, v5}, Lcom/adobe/air/OrientationManager;->access$702(Lcom/adobe/air/OrientationManager;I)I

    .line 306
    .end local v0    # "accelRotation":I
    .end local v1    # "eventCancelled":Z
    :cond_2
    :goto_2
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    iget-object v5, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v5}, Lcom/adobe/air/OrientationManager;->access$000(Lcom/adobe/air/OrientationManager;)I

    move-result v5

    invoke-static {v4, v5}, Lcom/adobe/air/OrientationManager;->access$202(Lcom/adobe/air/OrientationManager;I)I

    .line 307
    return-void

    .line 247
    :cond_3
    if-lt p1, v5, :cond_4

    if-ge p1, v8, :cond_4

    .line 249
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v5

    invoke-static {v4, v5}, Lcom/adobe/air/OrientationManager;->access$002(Lcom/adobe/air/OrientationManager;I)I

    .line 250
    sget-object v4, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v4}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v3

    goto/16 :goto_0

    .line 252
    :cond_4
    if-lt p1, v8, :cond_5

    if-ge p1, v9, :cond_5

    .line 254
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v5

    invoke-static {v4, v5}, Lcom/adobe/air/OrientationManager;->access$002(Lcom/adobe/air/OrientationManager;I)I

    .line 255
    sget-object v4, Lcom/adobe/air/OrientationManager$EOrientation;->UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v4}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v3

    goto/16 :goto_0

    .line 257
    :cond_5
    if-lt p1, v9, :cond_6

    const/16 v4, 0x13b

    if-ge p1, v4, :cond_6

    .line 259
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v5

    invoke-static {v4, v5}, Lcom/adobe/air/OrientationManager;->access$002(Lcom/adobe/air/OrientationManager;I)I

    .line 260
    sget-object v4, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v4}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v3

    goto/16 :goto_0

    .line 262
    :cond_6
    if-ltz p1, :cond_7

    if-lt p1, v5, :cond_8

    :cond_7
    const/16 v4, 0x13b

    if-lt p1, v4, :cond_0

    const/16 v4, 0x168

    if-ge p1, v4, :cond_0

    .line 264
    :cond_8
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v5

    invoke-static {v4, v5}, Lcom/adobe/air/OrientationManager;->access$002(Lcom/adobe/air/OrientationManager;I)I

    .line 265
    sget-object v4, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v4}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v3

    goto/16 :goto_0

    .line 286
    .restart local v0    # "accelRotation":I
    .restart local v1    # "eventCancelled":Z
    :cond_9
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$600(Lcom/adobe/air/OrientationManager;)Z

    move-result v2

    .line 287
    .local v2, "orientationChanged":Z
    if-eqz v2, :cond_1

    .line 289
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    iget-object v5, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v5}, Lcom/adobe/air/OrientationManager;->access$300(Lcom/adobe/air/OrientationManager;)I

    move-result v5

    invoke-virtual {v4, v5, v3}, Lcom/adobe/air/OrientationManager;->nativeOrientationChanged(II)V

    .line 290
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4, v3}, Lcom/adobe/air/OrientationManager;->access$302(Lcom/adobe/air/OrientationManager;I)I

    goto/16 :goto_1

    .line 298
    .end local v0    # "accelRotation":I
    .end local v1    # "eventCancelled":Z
    .end local v2    # "orientationChanged":Z
    :cond_a
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$100(Lcom/adobe/air/OrientationManager;)Z

    move-result v4

    if-ne v4, v6, :cond_2

    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$800(Lcom/adobe/air/OrientationManager;)Z

    move-result v4

    if-ne v4, v6, :cond_2

    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$200(Lcom/adobe/air/OrientationManager;)I

    move-result v4

    iget-object v5, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v5}, Lcom/adobe/air/OrientationManager;->access$000(Lcom/adobe/air/OrientationManager;)I

    move-result v5

    if-eq v4, v5, :cond_2

    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    .line 299
    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$200(Lcom/adobe/air/OrientationManager;)I

    move-result v4

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v5

    if-eq v4, v5, :cond_2

    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$000(Lcom/adobe/air/OrientationManager;)I

    move-result v4

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v5

    if-eq v4, v5, :cond_2

    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$900(Lcom/adobe/air/OrientationManager;)F

    move-result v4

    const v5, 0x40533333    # 3.3f

    cmpg-float v4, v4, v5

    if-gez v4, :cond_2

    .line 301
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$400(Lcom/adobe/air/OrientationManager;)Landroid/app/Activity;

    move-result-object v4

    if-eqz v4, :cond_b

    .line 302
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4}, Lcom/adobe/air/OrientationManager;->access$400(Lcom/adobe/air/OrientationManager;)Landroid/app/Activity;

    move-result-object v4

    const/4 v5, 0x2

    invoke-virtual {v4, v5}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 303
    :cond_b
    iget-object v4, p0, Lcom/adobe/air/OrientationManager$1;->this$0:Lcom/adobe/air/OrientationManager;

    invoke-static {v4, v7}, Lcom/adobe/air/OrientationManager;->access$802(Lcom/adobe/air/OrientationManager;Z)Z

    goto/16 :goto_2
.end method
